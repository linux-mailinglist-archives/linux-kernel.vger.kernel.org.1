Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7D2E79A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgL3NYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:24:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:46906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgL3NYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77B2BABA1;
        Wed, 30 Dec 2020 13:23:38 +0000 (UTC)
Date:   Wed, 30 Dec 2020 14:23:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201230132337.svr2rlygfeofd45q@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <BYAPR04MB4965A005E5CED1890293ED7A86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965A005E5CED1890293ED7A86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

On Thu, Dec 10, 2020 at 04:35:14AM +0000, Chaitanya Kulkarni wrote:
> Enzo,
> On 12/9/20 13:39, Enzo Matsumiya wrote:
> > Fix a possible NULL pointer dereference when trying to read
> > hwmon sysfs entries associated to NVMe-oF devices that were
> > hot-removed or disconnected.
> >
> > Unregister the NVMe hwmon device upon controller teardown
> > (nvme_stop_ctrl()).
> >
> > Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> (Without looking into the code)
> 
> Do you have blktests testcases for NVMeOFhot-removed and disconnected
> device scenario to produce the problem ?

Here is a rough blktests' test to reproduce the problem. There is
clearly a race as the crash not always happens at the same iteration. On
my system I was able to hit consistently within 50 iterations. Maybe you
need to tweak it on your system to reproduce it.

Thanks,
Daniel



#!/bin/bash
# SPDX-License-Identifier: GPL-2.0+
# Copyright (c) 2020 SUSE LLC
#
# Test NVMeOF read hwmon device info
. tests/nvme/rc

DESCRIPTION="read hwmon device info"

requires() {
	_nvme_requires
	_have_modules loop
	_require_nvme_trtype_is_fabrics
}

_get_nvme_hwmon_devs() {
	echo "/sys/devices/virtual/nvme-fabrics/ctl/hwmon*"
}

_read_nvme_hwmon_attr() {
	hwmon_devs="$(_get_nvme_hwmon_devs)"
	for hwmon in "${hwmon_devs}"; do
		cat ${hwmon}"/name"
		cat ${hwmon}"/temp1_label"
		cat ${hwmon}"/temp1_alarm"
		cat ${hwmon}"/temp1_input"
	done
}

test() {
	echo "Running ${TEST_NAME}"

	_setup_nvmet

	local port
	local loop_dev
	local file_path="$TMPDIR/img"
	local subsys_name="blktests-subsystem-1"

	truncate -s 1G "${file_path}"

	loop_dev="$(losetup -f --show "${file_path}")"

	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
	port="$(_create_nvmet_port "${nvme_trtype}")"
	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"

	for i in $(seq 1 50); do
		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
		_read_nvme_hwmon_attr
		_nvme_disconnect_subsys "${subsys_name}"
		_read_nvme_hwmon_attr
	done

	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
	_remove_nvmet_subsystem "${subsys_name}"
	_remove_nvmet_port "${port}"

	losetup -d "${loop_dev}"

	rm "${file_path}"

	echo "Test complete"
}
