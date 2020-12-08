Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5072D311D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgLHRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgLHRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:31:14 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53939C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:30:34 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ED52C300;
        Tue,  8 Dec 2020 17:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED52C300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607448634; bh=FERq4cImv3osP50qz+SgLqb5oei6VpqlBDGrQMlk47I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPi+IjbRVDPcaiXzmiJ8QPXH2lnrL0CVTthTELvpFsqBQmhk8Ze/77K3Mg4xk4VSi
         M17u3oo/8i9WG04DSBmnR+ZyLrBCJdsU0sdDhjCllvbpclO2rRp99zmo3zzPsoHBry
         1mTLfBDM0g/E8FbgXYLT8tt1Pr8L647GTWArLrl2fHmJ5HHbjezgu8JWNtg0c1jZba
         pXsmvhf+FSQQVYxzMWl1mDwlMTfn+1jMpZUkWJH1FnKsiZVLQ5JKq5G1gdgorV2WuT
         8iItp7yLyqyJZ3UWCu3NLsdnThwxgvwB5SETNNhcVKJ6HN1FWBH3I82Hk7e22y88IN
         BTvV7a29gWuxQ==
Date:   Tue, 8 Dec 2020 10:30:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] Documentation: fix multiple typos found in the
 admin-guide subdirectory
Message-ID: <20201208103032.0b60b26f@lwn.net>
In-Reply-To: <20201204072848.GA49895@spblnx124.lan>
References: <20201204072848.GA49895@spblnx124.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 10:28:48 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> Fix thirty five typos in dm-integrity.rst, dm-raid.rst, dm-zoned.rst,
> verity.rst, writecache.rst, tsx_async_abort.rst, md.rst, bttv.rst,
> dvb_references.rst, frontend-cardlist.rst, gspca-cardlist.rst, ipu3.rst,
> remote-controller.rst, mm/index.rst, numaperf.rst, userfaultfd.rst,
> module-signing.rst, imx-ddr.rst, intel-speed-select.rst,
> intel_pstate.rst, ramoops.rst, abi.rst, kernel.rst, vm.rst

I've applied this patch, but made one important change:

> Reviewed-by: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>

Neither Randy nor I provided you with a Reviewed-by tag for this patch, so
you have no business adding it.  I've removed these.  Never add tags like
this unless the person named therein has offered them.

jon
