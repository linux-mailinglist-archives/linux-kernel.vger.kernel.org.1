Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144832FE50C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAUIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:32:23 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:58556 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAUIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:25:47 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210121082458epoutp01ee889ae0192653c212f57f383bcffc6b~cMcdOdeVd1522215222epoutp01q
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210121082458epoutp01ee889ae0192653c212f57f383bcffc6b~cMcdOdeVd1522215222epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611217498;
        bh=zw5EA1aVVTvofbcRpDcudWJ5RfaXPV+nGIF5o4VkaA4=;
        h=Date:From:To:Cc:Subject:Reply-To:In-Reply-To:References:From;
        b=jCNTzoMcmhqgZtB4Zy6arHNZv7JVnp45cRJcHLto62VICd9JSWW1zxSASiE3LlD77
         uCC7ztPcK7YncrCM8uUaJVMbhZZ0u0QD1EnzHedXSjX1AwCDZLaj8UtPFyuyr5E70u
         czxlI23JkesBMjgJZ7fIXzO9QvnFHC8GGfW95nW0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210121082458epcas2p2e349b3a1cb620cd5d119a3e77c514388~cMcc65IKi2836128361epcas2p2t;
        Thu, 21 Jan 2021 08:24:58 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DLwRr4Rb6z4x9Q0; Thu, 21 Jan
        2021 08:24:56 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.CC.05262.75A39006; Thu, 21 Jan 2021 17:24:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210121082454epcas2p3d770484a34193f5c6dce9e16005d1347~cMcZqfWIb0771807718epcas2p3c;
        Thu, 21 Jan 2021 08:24:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210121082454epsmtrp25b29142ea8fcc1262bd5408a733278c0~cMcZpyfGL2382223822epsmtrp26;
        Thu, 21 Jan 2021 08:24:54 +0000 (GMT)
X-AuditID: b6c32a47-b81ff7000000148e-24-60093a57a5b3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.4E.08745.65A39006; Thu, 21 Jan 2021 17:24:54 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210121082454epsmtip2268341175915e445f0c13f950938d1aa~cMcZfPXfP2528225282epsmtip2D;
        Thu, 21 Jan 2021 08:24:54 +0000 (GMT)
Date:   Thu, 21 Jan 2021 17:13:33 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "supporter:USB SUBSYSTEM open list:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Message-ID: <20210121081333.GA2977@ubuntu>
Reply-To: eg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <6c6429da-5d27-2d6a-9bcf-3606810e71a6@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmqW64FWeCwe5dQhbH2p6wWzQvXs9m
        cXnXHDaLRctamS1WLTjAbrG2aRabA5vH5b5eJo9NqzrZPPbPXcPusWX/Z0aPz5vkAlijcmwy
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5QUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfmFpfmpesl5+daGRoYGJkCVSbkZCza
        3c5asFSjYte3s2wNjA0KXYycHBICJhLbLzaxdzFycQgJ7GCUmHrhLwuE84lRYvOnNjYI5zOj
        xOon79hhWlY+e8cEkdjFKNE9YTlU1RMgZ+55NpAqFgFVib51H1lBbDYBLYl7P04wg9giAiES
        d39uZgZpYBZ4zCix+/UcJpCEsIC7xMTbd1lAbF6ghs//zzKC2EIC5hL/ls2HigtKnJz5BMzm
        FHCSWHR1MpDNwSEqoCLx6mA9yEwJgUYOiT+fzjGCxCUEXCSWPyuBuFpY4tXxLVAfSEl8freX
        DaKkXGLRfDuI1g5GiTWfINZKCBhLzHrWDmYzC2RIvDm0nQmiXlniyC0WiDCfRMfhv+wQYV6J
        jjYhiE5liemXJ7BC2JISB1+fY4Yo8ZA4uU4L4qdVTBInOhgnMCrMQvLWLCS7IGwdiQW7P7HN
        AupmFpCWWP6PA8LUlFi/S38BI+sqRrHUguLc9NRiowJj5GjfxAhOp1ruOxhnvP2gd4iRiYPx
        EKMEB7OSCO8jS44EId6UxMqq1KL8+KLSnNTiQ4ymwAibyCwlmpwPTOh5JfGGpkZmZgaWpham
        ZkYWSuK8xQYP4oUE0hNLUrNTUwtSi2D6mDg4pRqYct2jo5OenTe7sbbryCs5+bUOTy97yXnf
        X7f6X+/BiX+725cd+X99yw/uP+7N1TtFZD7M5Fqnp7/26NOoZfu37d2WZ7l692cuww+xu+9/
        tX/p92el1pm8fc+eKT9vUdJW789J2H3lzkaT/3eOH9u5Volner3D4pKznzZv+uz/e090n2Cb
        8SfOnetXca/1l+f01VgbG5Jhait/wlsr4pQDu5r4q21beVqjvWxilW7PnFde8jPvOOO5X/o9
        x16yK807+2/9om9XZLaeqoiMq5285MDlnlk7E1Uq2fQkPEqe8ri7Z01j0NvWEDL/p6BP1uGG
        RJPGpznhv3n9Zs9scJuw8amFQ9DX5iipRXV2//99W6TEUpyRaKjFXFScCAB/Zp0jMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG6YFWeCwYKJJhbH2p6wWzQvXs9m
        cXnXHDaLRctamS1WLTjAbrG2aRabA5vH5b5eJo9NqzrZPPbPXcPusWX/Z0aPz5vkAlijuGxS
        UnMyy1KL9O0SuDJab09lLXiqWrHstWcD403ZLkZODgkBE4mVz94xdTFycQgJ7GCUWLLuIyNE
        QlJi6dwb7BC2sMT9liOsEEWPGCX2dr1lAkmwCKhK9K37yApiswloSdz7cYIZxBYRCJFom9XN
        CNLALPCYUeLym11sIAlhAXeJibfvsoDYvEANn/+fBdsmJGAu8W/ZfBaIDauYJF7uWcUEUSQo
        cXLmE7AGZqCGG/9eAsU5gGxpieX/OEDCnAJOEouuTmYBCYsKqEi8Olg/gVFoFpLmWUiaZyE0
        L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwRWlo7GPes+qB3iJGJg/EQowQH
        s5II7yNLjgQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUa
        mBL/7LeXs3q6IJaRLcVIcmfyLabQE5r1+jdYPh6Ml4qxUedRNuG+Gvp8IZviB9/vf/laIzfW
        RSjMk/13QlzozMyNi0/ENF1p8V8wM0n0R9GnCXdemVYLmW6fP/OqQ9+T0IBvNoJbZ0y8MeHM
        6YcFM/Y2ty922VhnrZsrvlF8yk4u0wozziUXYk6JpTgq9QVt9IuNtXTewv94Yv+2xz+mnak5
        tXn/dEv7Px0sx35+3xzr2DfLtVaneUPX1aP3kySb3X1iHH+o9PuwVXDM9pBYs+Z1zt2pfkx9
        0Zs22pT6sMzv/GVlNdVt+YqbAmrHlx36f63smrCM5fRM569a0p+e+C2V493NVf1h6951/F+a
        9JRYijMSDbWYi4oTARYYXrv3AgAA
X-CMS-MailID: 20210121082454epcas2p3d770484a34193f5c6dce9e16005d1347
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----s6LrMQgGwfxkCWV1T143f3B6inMeIHv7NdBy0Tbz5LTIEOJu=_1679f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
        <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
        <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
        <20210121064956.GA69382@ubuntu>
        <6c6429da-5d27-2d6a-9bcf-3606810e71a6@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------s6LrMQgGwfxkCWV1T143f3B6inMeIHv7NdBy0Tbz5LTIEOJu=_1679f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Jan 20, 2021 at 11:44:05PM -0800, Wesley Cheng wrote:
> 
> 
> On 1/20/2021 10:49 PM, Jung Daehwan wrote:
> > Hi,
> > 
> > On Thu, Jan 21, 2021 at 01:00:32AM +0000, Thinh Nguyen wrote:
> >> Hi,
> >>
> >> Daehwan Jung wrote:
> >>> Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
> >>> entering suspend. That's why it needs to check whether suspend
> >>>
> >>> 1. dwc3 sends disconnect uevent and turn off. (suspend)
> >>> 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
> >>> 3. It causes unexpected behavior like ITMON error.
> >>>
> >>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >>> ---
> >>>  drivers/usb/dwc3/gadget.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >>> index ee44321..d7d4202 100644
> >>> --- a/drivers/usb/dwc3/gadget.c
> >>> +++ b/drivers/usb/dwc3/gadget.c
> >>> @@ -2093,6 +2093,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >>>  	unsigned long		flags;
> >>>  	int			ret;
> >>>  
> >>> +	if (pm_runtime_suspended(dwc->dev))
> >>> +		return 0;
> >>> +
> >>>  	is_on = !!is_on;
> >>>  
> >>>  	/*
> >>> @@ -2403,6 +2406,9 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
> >>>  	unsigned long		flags;
> >>>  	u32			reg;
> >>>  
> >>> +	if (pm_runtime_suspended(dwc->dev))
> >>> +		return;
> >>> +
> >>>  	spin_lock_irqsave(&dwc->lock, flags);
> >>>  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
> >>>  	reg &= ~(DWC3_DCFG_SPEED_MASK);
> >>
> >> This is already addressed in Wesley Cheng's patches. Can you try the
> >> latest changes of DWC3 in Greg's usb-next branch?
> >>
> >> Thanks,
> >> Thinh
> > 
> > I checked Wesly Cheng's pathces but it's not same.
> > What I want to do for this patch is to avoid pullup from platform side.
> > (android in my case)
> > 
> > It's possible that platform side tries to pullup by UDC_Store after usb is already disconnected.
> > It can finally run controller and enable irq.
> > 
> > I think we have to avoid it and other possible things related to platform side.
> > 
> > 
> 
> Hi Daehwan,
> 
> I think what you're trying to do is to avoid the unnecessary runtime
> resume if the cable is disconnected and userspace attempts to
> bind/unbind the UDC.
> 
> I'm not exactly sure what patches you've pulled in, but assuming you
> didn't pull in any of the recent suspend changes:
> 
> usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
> usb: dwc3: gadget: Preserve UDC max speed setting
> 
> Please consider the following scenario:
> 1.  USB connected
> 2.  UDC unbinded
> 3.  DWC3 will continue to stay in runtime active, since dwc->connected =
> true
> 
> In this scenario, we should allow the DWC3 to enter runtime suspend,
> since runstop has been disabled.
> 
> If you have pulled in the above changes, and adding your changes on top
> of it, then consider the following:
> 1.  USB connected
> 2.  UDC unbinded
> 3.  DWC enters runtime suspend (due to the above changes)
> 4.  UDC binded
> 
> The check for pm_runtime_suspended() will block step#4 from re-enabling
> the runstop bit even if the USB cable is connected.
> 
> Thanks
> Wesley Cheng
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

Hi Wesley

The check for runtime_suspended() will block re-enabling the runstop bit as
you said after pulling your patches in.

UDC is contolled by userspace and it's possible UDC can be binded
unexpectedly. That's why I think it needs to handle it even if the
problem is from userspace.

Below is an example in my environment.

1. USB disconnected
2. UDC unbinded
3. DWC enters runtime suspend
4. UDC binded unexpectedly
5. Gadget start and enable irq


Line 9823: [   36.024428][ T2889] dwc3 10e00000.dwc3: Turn off gadget dwc3-gadget
Line 9827: [   36.024572][ T2889] __dwc3_gadget_stop called
Line 9828: [   36.025083][ T2603] android_work: sent uevent USB_STATE=DISCONNECTED
Line 9842: [   36.200896][  T554] usb_gadget_disconnect
Line 9843: [   36.200916][  T554] dwc3_gadget_pullup : 0
Line 9844: [   36.201165][  T554] dwc3_gadget_pullup: get_sync fail
Line 9845: [   36.201197][  T554] dwc3_gadget_stop called
Line 9846: [   36.201250][  T451] android_work: did not send uevent (0 0 0000000000000000)
Line 9849: [   36.202343][    T1] init: processing action (sys.usb.config=adb && sys.usb.configfs=1..
Line 9851: [   36.203622][    T1] dwc3_gadget_start called
Line 9852: [   36.204079][    T1] usb_gadget_connect
Line 9853: [   36.204086][    T1] dwc3_gadget_pullup : 1
Line 9854: [   36.204091][    T1] __dwc3_gadget_start called

Best Regrars,
Jung Daehwan

------s6LrMQgGwfxkCWV1T143f3B6inMeIHv7NdBy0Tbz5LTIEOJu=_1679f_
Content-Type: text/plain; charset="utf-8"


------s6LrMQgGwfxkCWV1T143f3B6inMeIHv7NdBy0Tbz5LTIEOJu=_1679f_--
