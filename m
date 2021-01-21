Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC82FE41E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbhAUHis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:38:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:17277 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbhAUHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:23:42 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210121072256epoutp020492f2d9beab3d2f2ea07b6f2d889a0b~cLmSxOqvY0551405514epoutp02z
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210121072256epoutp020492f2d9beab3d2f2ea07b6f2d889a0b~cLmSxOqvY0551405514epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611213776;
        bh=s+VACPfSnf1IN7l9c0PuSue2sZjrDh2l/uhILldXiAI=;
        h=Date:From:To:Cc:Subject:Reply-To:In-Reply-To:References:From;
        b=VSxLaP8lPgIc+41c6O/38fro5i8h6a/VRZ8O4ZeVco8gbiB+5gk6BBsMUycRaplZT
         fOLrhfi7ZoEYX67rkdhvoDj5ceB4XLm+l7i+UHa7HXSssWydb4alrgyWXgeHd7PrHs
         U2H7f2F1IbyHrt6cV3zksIf5RPQ8iVlNw8UTWDpg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210121072256epcas2p29cb6ddeab37509a768f1207f7c869c14~cLmSYf_Ed0334203342epcas2p23;
        Thu, 21 Jan 2021 07:22:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DLv4H0LnBz4x9Q8; Thu, 21 Jan
        2021 07:22:55 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.28.52511.CCB29006; Thu, 21 Jan 2021 16:22:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210121072252epcas2p3d632d03e00263cdd9bf7b65690ea4cb5~cLmO9lpqo1161011610epcas2p3M;
        Thu, 21 Jan 2021 07:22:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210121072252epsmtrp2aa930ac61bb7b7e1e27668c89933fa81~cLmO8-rHs2747627476epsmtrp2J;
        Thu, 21 Jan 2021 07:22:52 +0000 (GMT)
X-AuditID: b6c32a48-4f9ff7000000cd1f-4d-60092bcce0b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.71.13470.CCB29006; Thu, 21 Jan 2021 16:22:52 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210121072252epsmtip1e83a60619cc684d071a7c2a12baabaed~cLmO0luUr1645316453epsmtip1W;
        Thu, 21 Jan 2021 07:22:52 +0000 (GMT)
Date:   Thu, 21 Jan 2021 16:11:31 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Message-ID: <20210121071131.GA84462@ubuntu>
Reply-To: eg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTTPeMNmeCQc9+G4tjbU/YLZoXr2ez
        uLxrDpvFomWtzA4sHptWdbJ57J+7ht3j8ya5AOaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4
        UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoG1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
        1IKUnAJDwwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjH3nljMXHBOsePDiMEsDYy9fFyMnh4SA
        icStT20sXYxcHEICOxgl7v64AeV8YpTYuWYlG4TzDciZu4IZpuXEl/2MEIm9jBJL3qwDSwgJ
        PGGU6N7GAWKzCKhKbPuxHyzOJqAlce/HCTBbREBZYsqPNiaQZmaBFYwSXQtPgiWEBdwlJt6+
        ywJi8wpoS7Tc2csOMdRc4t+y+VBxQYmTM5+A2ZwCDhITZ70C6uXgEBVQkXh1sB5kpoTAI3aJ
        c/83s0Bc6iLxZN5TJghbWOLV8S3sELaUxOd3e9lAeiUEyiUWzbeD6O1glFjz6SwjRI2xxKxn
        7YwgNcwCGRJzr5pClCtLHLkFNp1ZgE+i4/Bfdogwr0RHmxBEo7LE9MsTWCFsSYmDr88xQ5R4
        SJxcpwUJtQuMEt+XfGWewKgwC8lfsxB2zQJboCOxYPcnNoiwtMTyfxwQpqbE+l36CxhZVzGK
        pRYU56anFhsVmCDH+iZGcJLU8tjBOPvtB71DjEwcjIcYJTiYlUR4H1lyJAjxpiRWVqUW5ccX
        leakFh9iNAVG2ERmKdHkfGCaziuJNzQ1MjMzsDS1MDUzslAS5y0yeBAvJJCeWJKanZpakFoE
        08fEwSnVwDRbfdZLjs2y6Y23cwufPwnc/X3etInbCgLfsSsvOSW0X8ZozyndXkenhIshBgtM
        fG9ach3w/Xau7uzVG18vi8c75K7Lt31kUX3+oFkHg1uF36an5z4kJWzOWTzj/fk/m85ujV+l
        +X9OwfIQ3zvBbTsmVxxy0XZbc2S1b37slgj3oDlz7paee831hVvbik/8HCfjhSWT7lZsZfy9
        136u8gG7Ew3Xnk42mpV5OuXspM47Fe8LW6QOLI3bdWS18guX5J/2ilcY3M5uj7hqrm5ok936
        bZOJ/Zb6jUa/5U5ucdPflbJW5nfV9heCni5xsQqTazsn6BkkCOdcqd52rqXuHGd+1kaBG3rr
        rYRtL5UsT/NQYinOSDTUYi4qTgQAxKdPjBsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO4Zbc4Eg/1nFCyOtT1ht2hevJ7N
        4vKuOWwWi5a1MjuweGxa1cnmsX/uGnaPz5vkApijuGxSUnMyy1KL9O0SuDIat31jLmjjr+jY
        foWtgfEZdxcjJ4eEgInEiS/7GbsYuTiEBHYzSszae4wZIiEpsXTuDXYIW1jifssRVoiiR4wS
        c64cYAFJsAioSmz7sR+sgU1AS+LejxNgtoiAssSUH21MIA3MAisYJS4vWswEkhAWcJeYePsu
        WDOvgLZEy529YBuEBMwl/i2bzwKx4QKjRPutuVBFghInZz4Bs5mBNtz49xJoEAeQLS2x/B8H
        SJhTwEFi4qxXzCBhUQEViVcH6ycwCs1C0jwLSfMshOYFjMyrGCVTC4pz03OLDQsM81LL9YoT
        c4tL89L1kvNzNzGCQ11Lcwfj9lUf9A4xMnEwHmKU4GBWEuF9ZMmRIMSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT51X1pPu9sy9IXt/8TkPeuGHNgg/X
        hNL51FVb610/zLKqvjJf65pgqdTJMkfRi3N6Z1rUZPCs0xT/wfRk2umtbGUcDx7kH97btE29
        QrK83Fn5x+KO5lOJLq82+M1IsVPIulSdELIn8tIJ8eJ/PV8eilxs3bhHnqlI4ML2iYmyqs1+
        Ic4qGS/Peu2JnKIyU9x34ttdzWkssp58ykvNG2sf355h023vrf0vseRU/N/nH+4Zn61o0dRy
        3evzP+XT9FunNwVc6U/5Jf7xPv+7UNfOv9Wx/d/PpEVXuX/pvPmHcWdyUfJ+ywMTe8pvnPQ0
        WhLALOKixvfgW8CFVVmZSdGC1nWPLet+Tg9Y+fjJGxklluKMREMt5qLiRACx/hnZ5AIAAA==
X-CMS-MailID: 20210121072252epcas2p3d632d03e00263cdd9bf7b65690ea4cb5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mNH5knzzkG0Mgn_4LE2W.vyl1feJgd8C-RJhbgQvYSfbcfg-=_15cf8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
        <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
        <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------mNH5knzzkG0Mgn_4LE2W.vyl1feJgd8C-RJhbgQvYSfbcfg-=_15cf8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On Thu, Jan 21, 2021 at 01:00:32AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> Daehwan Jung wrote:
> > Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
> > entering suspend. That's why it needs to check whether suspend
> >
> > 1. dwc3 sends disconnect uevent and turn off. (suspend)
> > 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
> > 3. It causes unexpected behavior like ITMON error.
> >
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index ee44321..d7d4202 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2093,6 +2093,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  	unsigned long		flags;
> >  	int			ret;
> >  
> > +	if (pm_runtime_suspended(dwc->dev))
> > +		return 0;
> > +
> >  	is_on = !!is_on;
> >  
> >  	/*
> > @@ -2403,6 +2406,9 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
> >  	unsigned long		flags;
> >  	u32			reg;
> >  
> > +	if (pm_runtime_suspended(dwc->dev))
> > +		return;
> > +
> >  	spin_lock_irqsave(&dwc->lock, flags);
> >  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
> >  	reg &= ~(DWC3_DCFG_SPEED_MASK);
> 
> This is already addressed in Wesley Cheng's patches. Can you try the
> latest changes of DWC3 in Greg's usb-next branch?
> 
> Thanks,
> Thinh

I checked Wesly Cheng's pathces but it's not same.
What I want to do for this patch is to avoid pullup from platform side.
(android in my case)

It's possible that platform side tries to pullup by UDC_Store after usb is already disconnected.
It can finally run controller and enable irq.

I think we have to avoid it and other possible things related to platform side.

BR,
Jung Daehwan

------mNH5knzzkG0Mgn_4LE2W.vyl1feJgd8C-RJhbgQvYSfbcfg-=_15cf8_
Content-Type: text/plain; charset="utf-8"


------mNH5knzzkG0Mgn_4LE2W.vyl1feJgd8C-RJhbgQvYSfbcfg-=_15cf8_--
