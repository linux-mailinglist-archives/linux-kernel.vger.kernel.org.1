Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8072871C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgJHJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJHJpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92521042;
        Thu,  8 Oct 2020 02:45:05 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CF63F70D;
        Thu,  8 Oct 2020 02:45:04 -0700 (PDT)
Date:   Thu, 8 Oct 2020 10:45:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     muhammad.husaini.zulkifli@intel.com
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: Re: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201008094501.ix2sdxorwhxchy5w@bogus>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:09:33AM +0800, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Add header file to handle API function for device driver to communicate
> with Arm Trusted Firmware.

[nit] Since it moved to trusted-firmware.org, it is no longer "Arm"
Trusted Firmware. It is now called Trusted Firmware - A profile(TF-A)
or Trusted Firmware - M profile (TF-M). Please update the subject and
the text above. I know it is silly but I am being asked to get this
fixed as it may create "confusion"(I don't know details, please don't
ask 😁)

Apart from various minor things Andy already pointed out, this looks
good. You can add by Ack once the above naming and all things pointed
by Andy are fixed.

--
Regards,
Sudeep
