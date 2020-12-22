Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24E02E0BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgLVOqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:46:17 -0500
Received: from mail.ispras.ru ([83.149.199.84]:44244 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgLVOqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:46:16 -0500
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 823CD40D4004;
        Tue, 22 Dec 2020 14:45:27 +0000 (UTC)
Date:   Tue, 22 Dec 2020 17:45:27 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: amd-pmc s2idle driver issues
In-Reply-To:  <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
Message-ID: <alpine.LNX.2.20.13.2012221720290.10565@monopod.intra.ispras.ru>
References: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>  <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020, Deucher, Alexander wrote:

> > I've tried the "platform/x86: amd-pmc: Add AMD platform support for
> > S2Idle"
> > patch on my Acer Swift SF314-42 laptop (Renoir SoC, Ryzen 4500U CPU) and
> > hit the following issues:
> > 
> > 1. The driver doesn't bind to any device. It has the following binding table:
> > 
> > +static const struct acpi_device_id amd_pmc_acpi_ids[] = {
> > +	{"AMDI0005", 0},
> > +	{"AMD0004", 0},
> > +	{ }
> > +};
> > 
> > This laptop has "AMD0005" instead. Adding it to the list allows the driver to
> > successfully probe.
> > 
> > 2. The debugfs interface does not seem to be very helpful. It shows
> > 
> > SMU FW Info: ffffffff
> > 
> > It's not very informative. The code seems to be fetching SMU version from
> > mmio, so I guess the file should be saying "FW version" rather than "FW
> > Info", and then, I think version number is not supposed to be "-1".
> > 
> 
> Does your platform support modern standby?  You may have to select between
> legacy S3 and modern standby in the sbios.

Yes. Out-of-the-box it's a "modern standby" laptop. There's a "hidden"
bios menu with extra settings that apparently allows to select legacy S3.
I did not change it, so I'm testing the "modern" mode.

Note that this driver fetches SMU version from MMIO, which looks odd to me:
elsewhere (i.e. in the amdgpu driver) SMU version is retrieved by issuing
the corresponding SMU command, as far as I can tell.

Alexander
