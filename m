Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E932F9C70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbhARJYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbhARJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:18:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E2C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d0B2hFv3lHdM9TBPzjM9IKfLfYu/9AxcqqtQjLF2crQ=; b=QkLUcq4X8dxRqsXPDc7Y9lJck
        3QIAiv0C0MkGBIJb3dDg7ZBcYhOV05UNg+TlQkkzDjScHmScwwlaUHiokzk0lOBaV43/+2xoGhWGf
        D+64OyCT9ahStm/k0XRMJT/jIp5xP/mJbxx2PHKz3w9zKF54QPGLWcKfLTcR5IPqzmKF0ZDhJ5R0m
        aYBlgL7QXtqZhxzgplPp8W6aXDTvcv/M8F+ULI07V2NO+63QSEZPCNQ4msrShdPKnsINYQhJxQawz
        +1pv2oTUHJVXv5G3VWvfK8lO12b6DWEwuTsxTmkCRFcII96Bq39l9AAm3MMZJ860iDK+YbDfMTdxZ
        BA2BqYang==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49488)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l1QfH-0006CK-Qh; Mon, 18 Jan 2021 09:17:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l1QfF-0003t7-Eh; Mon, 18 Jan 2021 09:17:33 +0000
Date:   Mon, 18 Jan 2021 09:17:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmerdabbelt@google.com,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v3 0/4] initrd: Use unified initrd reserve function in
 ARM/RISCV
Message-ID: <20210118091733.GD1551@shell.armlinux.org.uk>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
 <48c006a8-a352-488c-4981-768faffbe343@huawei.com>
 <20210117100903.GB1551@shell.armlinux.org.uk>
 <cc47f8cf-8778-43ab-77de-9dd220de7c26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc47f8cf-8778-43ab-77de-9dd220de7c26@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:01:40AM +0800, Kefeng Wang wrote:
> 
> On 2021/1/17 18:09, Russell King - ARM Linux admin wrote:
> > On Sun, Jan 17, 2021 at 12:57:55PM +0800, Kefeng Wang wrote:
> > > Correct Russell's mail address (from linux@armlinux.org.uk to
> > > rmk+kernel@armlinux.org.uk, should update the MAINTAINERS)
> > No. MAINTAINERS is correct.
> 
> I got following message,  so I check mail of your recent patches, and send a
> new one.
> 
> Please ignore it, there may be some other problems.
> 
> "*Delivery has failed to these recipients or groups:*
> 
> linux@armlinux.org.uk <mailto:linux@armlinux.org.uk>
> A communication failure occurred during the delivery of this message. Please
> to resend the message later. If the problem continues, contact your
> helpdesk."

That is a most unhelpful bounce message - I suppose it's designed for
non-technical people to ensure that the problem can't be resolved.

From what I can see from my end, every attempt involving your email
address last week (wangkefeng.wang@huawei.com) has been successful, so
I suspect the problem is not at my end.

In any case, all @armlinux.org.uk addresses hit the same server, so
if there's a "communication failure" for the domain, it would affect
all local-parts equally.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
