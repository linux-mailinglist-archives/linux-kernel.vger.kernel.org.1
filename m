Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1C282D2F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgJDTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:22:10 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40319 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgJDTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:22:10 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2020 15:22:09 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A3C61100CF15E;
        Sun,  4 Oct 2020 21:13:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5E2E1239FE8; Sun,  4 Oct 2020 21:13:29 +0200 (CEST)
Date:   Sun, 4 Oct 2020 21:13:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com
Subject: Re: [PATCH v7 3/5] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Message-ID: <20201004191329.GA27962@wunner.de>
References: <20201003075514.32935-1-haifeng.zhao@intel.com>
 <20201003075514.32935-4-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003075514.32935-4-haifeng.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 03:55:12AM -0400, Ethan Zhao wrote:
> When root port has DPC capability and it is enabled, then triggered by
> errors, DPC DLLSC and PDC etc interrupts will be sent to DPC driver, pciehp
> drivers almost at the same time.

Do the DLLSC and PDC events occur as a result of handling the error
or do they occur independently?

If the latter, I don't see how we can tell whether the card in the
slot is still the same.

If the former, holding the hotplug slot's reset_lock and doing something
along the lines of pciehp_reset_slot() (or calling it directly) might
solve the race.

Thanks,

Lukas
