Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51628EF76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgJOJmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:42:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:32790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388795AbgJOJmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:42:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602754920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGUEZhw5OsOWwTbxcg48LYkVTLy0xSGFFDqEYGHwsdY=;
        b=pCExSGjFkleCxW8TLXo0dw77TlP1sqwZmF77XE/mK0vyOkMZ4ghYySDaBHg+XIouJLZPml
        qVnmvJ8YbQRmhTKyWoxir7/tk01pEtSBAtrrTmsA4v7gJq2lLF+fezqqANGs+lSr7jYKuA
        2nYuV3f51cs55UHSonHP243h9bIZs94=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAFECAFFB;
        Thu, 15 Oct 2020 09:42:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] xen: Kconfig: nest Xen guest options
To:     Jason Andryuk <jandryuk@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20201014175342.152712-1-jandryuk@gmail.com>
 <20201014175342.152712-3-jandryuk@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <d8a8ed95-ed55-4ccf-1b54-8d97db908742@suse.com>
Date:   Thu, 15 Oct 2020 11:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014175342.152712-3-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.20 19:53, Jason Andryuk wrote:
> Moving XEN_512GB allows it to nest under XEN_PV.  That also allows
> XEN_PVH to nest under XEN as a sibling to XEN_PV and XEN_PVHVM giving:
> 
> [*]   Xen guest support
> [*]     Xen PV guest support
> [*]       Limit Xen pv-domain memory to 512GB
> [*]       Xen PV Dom0 support

This has currently a wrong text/semantics:

It should be split to CONFIG_XEN_DOM0 and CONFIG_XEN_PV_DOM0.

Otherwise the backends won't be enabled per default for a PVH-only
config meant to be Dom0-capable.

You don't have to do that in your patches if you don't want to, but
I wanted to mention it with you touching this area of Kconfig.

> [*]     Xen PVHVM guest support
> [*]     Xen PVH guest support
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
