Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23392EEE5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhAHINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbhAHINK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:13:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A3D23435;
        Fri,  8 Jan 2021 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610093550;
        bh=GXjJRIf+uhfmYfG9Tj80Dq5QjeyrK/HWMpHKqDUN2tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/MrHrJ7zdBAVnVO/LDNEUxb3W8HNj33jdiwSIm83uBI7GOAScSb7CDs4xGMiD8cl
         tulmbYGCmMs/+1llFrYWJNzyBdF0UtJGwBmixBI8oGjRLuDKB3E2PCu6nk/sjc9759
         Lf8p+W2a2aPR3utH59cj7VVDWZP4Tz3Lji3A1FTQ=
Date:   Fri, 8 Jan 2021 09:12:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com,
        vgoyal@redhat.com, lijiang@redhat.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <X/gT6jQTaFkqqIGt@kroah.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108033248.GA4959@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:32:48AM +0800, Baoquan He wrote:
> On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > The offset of the field 'init_uts_ns.name' has changed
> > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> 
> This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> commit 9a56493f6942 is merged into 5.9-rc2.
> 
> Below tag and CC should have been added into patch when posted. 
> 
> Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> Cc: <stable@vger.kernel.org>
> 
> Hi Greg,
> 
> Do we still have chance to make it added into stable?

Sure, what is the git commit id of this patch in Linus's tree?

In the future, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
