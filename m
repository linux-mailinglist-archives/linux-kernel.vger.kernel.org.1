Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC89C2B0BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKLSAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgKLSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:00:09 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB83C0613D1;
        Thu, 12 Nov 2020 10:00:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so6105240qkb.7;
        Thu, 12 Nov 2020 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nWQxQxmFLSVrQK0chW1Meim1NDrbshpHTTnicdDWmbA=;
        b=i/YhZTJPWlL4BQgh8dJHPFTZQ9sCwFF2v4JYEYB8CnHKo90Fykys0su4WrRtDcprjg
         il20NHsql+ux6cH4Zb2dEX1ZjsiPZexHqHn8oPzDC/DhwJuuEn/zSbxPXoyHF0u4uq8v
         bthtwNCmxPagN0Tvi4dHTXKOMY+O8DRFertCE3bBUhLXHGvU6rWI+yuztcxnpI5FbpXG
         7mVrRqksOjKYjlYIo46HXOTnTN6T8xGQj8QZbpzN6CzotJLhVvfFTBbh5u+gWQOKbjwT
         S59eKHkCKiXrSJ5mWxR2wLqt6TT8BveOmKI+dUiBcKeTq9czGHP4GQHotAOkNwkE7Kp8
         GnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWQxQxmFLSVrQK0chW1Meim1NDrbshpHTTnicdDWmbA=;
        b=DY5S9ZrWcXLqdSVnHvTC+en2iSDOzCbC/n8K4jm4KAtQ0rJD7aHAw7s34ZNhponbGD
         +207/TlbkGR5FMEdHvFi3opWT8ONz6ty9BIglJqQ+zxWw4bl25T/JIA00SFcKA0eY85g
         CkjXAGSVAVjNDHByWDDL+ePkuZg1eod+YRc3u+ce4X8ISqfaGLfVPn1V3ifDff2VlAcX
         uAcMBeLB3Zp7V9+Xofb2kDQQaLflC8CTnj9w34lsdyiUc+41C3n9XoM9CyclX/Se0Bo4
         AUt+TaVUYRx/HUgBrsm7uodvCh4YgWzPZ92wX5LRN5Z4DoYGcIoVOMAoJc4PzTHvCyd4
         UxuQ==
X-Gm-Message-State: AOAM531RhZ63oaLJE6ZBrtiQLob4SC6ZVrUEACQZB+skVGhbFC2YjQsW
        2YQi5l+utK4g0pPsFLSV3Gg=
X-Google-Smtp-Source: ABdhPJyuF0i2RSc/0wPNVEZueWQV00u5c0X1138yjJ1kLVDmdzhW9ZII0BPTlC1wsnVX2I31hzHCSQ==
X-Received: by 2002:a37:b342:: with SMTP id c63mr1048937qkf.146.1605204008659;
        Thu, 12 Nov 2020 10:00:08 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q20sm5369269qtn.80.2020.11.12.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:00:07 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:00:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] usb: fix a few cases of -Wfallthrough
Message-ID: <20201112180006.GA934688@ubuntu-m3-large-x86>
References: <20201111014716.260633-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111014716.260633-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 05:47:14PM -0800, Nick Desaulniers wrote:
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. Clang will still warn on cases where there is a
> fallthrough to an immediate break. Add explicit breaks for those cases.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Aside from a minor nit/question below:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/usb/core/config.c    | 1 +
>  drivers/usb/host/ehci-hcd.c  | 2 +-
>  drivers/usb/host/ohci-hcd.c  | 2 +-
>  drivers/usb/host/ohci-hub.c  | 1 +
>  drivers/usb/host/xhci-ring.c | 2 ++
>  5 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 562a730befda..b199eb65f378 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -1076,6 +1076,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
>  		case USB_PTM_CAP_TYPE:
>  			dev->bos->ptm_cap =
>  				(struct usb_ptm_cap_descriptor *)buffer;
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 3575b7201881..e358ae17d51e 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -867,7 +867,7 @@ static int ehci_urb_enqueue (
>  		 */
>  		if (urb->transfer_buffer_length > (16 * 1024))
>  			return -EMSGSIZE;
> -		/* FALLTHROUGH */
> +		fallthrough;

This is fixing the same kind of warnings but it is not called out in the
commit message. Maybe this hunk and the next hunk should be in a
separate patch? No strong preference either way.

>  	/* case PIPE_BULK: */
>  	default:
>  		if (!qh_urb_transaction (ehci, urb, &qtd_list, mem_flags))
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 73e13e7c2b46..1f5e69314a17 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -171,7 +171,7 @@ static int ohci_urb_enqueue (
>  
>  			/* 1 TD for setup, 1 for ACK, plus ... */
>  			size = 2;
> -			/* FALLTHROUGH */
> +			fallthrough;
>  		// case PIPE_INTERRUPT:
>  		// case PIPE_BULK:
>  		default:
> diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
> index 44504c1751e0..f474f2f9c1e4 100644
> --- a/drivers/usb/host/ohci-hub.c
> +++ b/drivers/usb/host/ohci-hub.c
> @@ -692,6 +692,7 @@ int ohci_hub_control(
>  		case C_HUB_OVER_CURRENT:
>  			ohci_writel (ohci, RH_HS_OCIC,
>  					&ohci->regs->roothub.status);
> +			break;
>  		case C_HUB_LOCAL_POWER:
>  			break;
>  		default:
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 167dae117f73..eac43a7b7f23 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2418,6 +2418,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>  			xhci_warn_ratelimited(xhci,
>  					      "WARN Successful completion on short TX for slot %u ep %u: needs XHCI_TRUST_TX_LENGTH quirk?\n",
>  					      slot_id, ep_index);
> +		break;
>  	case COMP_SHORT_PACKET:
>  		break;
>  	/* Completion codes for endpoint stopped state */
> @@ -2962,6 +2963,7 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
>  		return -EINVAL;
>  	case EP_STATE_HALTED:
>  		xhci_dbg(xhci, "WARN halted endpoint, queueing URB anyway.\n");
> +		break;
>  	case EP_STATE_STOPPED:
>  	case EP_STATE_RUNNING:
>  		break;
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
