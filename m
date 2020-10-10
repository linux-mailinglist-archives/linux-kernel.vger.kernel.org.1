Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D128A21A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgJJWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgJJTO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:14:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44AC05BD2D;
        Sat, 10 Oct 2020 08:46:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n61so11782298ota.10;
        Sat, 10 Oct 2020 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77d5X5ZtNoznypcZc20yzAR7XwV/B5sLmMBtpT0eIs0=;
        b=ohpYkoynygMJmbx+5NSwRmH1cm6Hng5v/a9GY5se13KSOkkewhSdPXh1cGMKdDDXqB
         h58Wny6D7atBtEWDNCfFVtjKw9qEw2TrktCIwoUA88AVlx/cB4gD54C/xKNgJkjOFG6L
         5KM9o3MfCIuGyy/ehmvTXggU9fjUzk7aoAw69kqxz/EZL0N22MRtwiAJ8UHCEXfOPK99
         Q5TrmOqqI7u73oqH7EIsN0SJ2pFpp25r9fmHf7Z0EHyDr1rlq07ktHXq73297iWVjuE8
         sJ4YL3cyjUTRlB0rCKtmcwS0Ai45seLP6l3/0UWyLIbqeH5ZfifBGxxBJEcmOFshaJYw
         DHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=77d5X5ZtNoznypcZc20yzAR7XwV/B5sLmMBtpT0eIs0=;
        b=RqriGVCbVC6R29IPV3xNSFfH2OIJI1uHVELzwsC2XUdJ4Kshp44Ff62ldH8fK/TEkv
         5NYJVLgHZbNIZFzMRmHcRVNYieVbW2CyNj7NX+k180162E2489/O9eYs46osIcPdW2EN
         ytiaJBXNy6bcah2HYv6Wfo9fEmWU8iMiPNHQ1/vt3i4Vc+WuhTZWZsaTS2TcyLuonsOq
         A/TjRP5WbPjWC40X8+lTh/wO7CXlFe2tiHCXY1lichE0inUkWCnF7RjREJ6ejhLXGi3Z
         uvKbAVpWl2nMnmcSpcIc9eD4XhfQKJWGv9T6g+1wgK/GOyQhDS6FajUGuhDg2P8Dar1v
         97Yg==
X-Gm-Message-State: AOAM530w6xDeOEF2YK/WElF0sE2uYJa2P1ZbOpWurqfQkhdYwCzzZOjZ
        8ven5rhblNFkETIbHPEatjs=
X-Google-Smtp-Source: ABdhPJwJ8/KFoOpJH+/Rhaywb9izxpn2VePM1efrrg/odMP8bzl1T6Q76eiJrj0O/VoaFkgsvr2XJw==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr11115721otm.289.1602344808241;
        Sat, 10 Oct 2020 08:46:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 81sm7133889oti.79.2020.10.10.08.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Oct 2020 08:46:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 10 Oct 2020 08:46:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Jun Li <jun.li@nxp.com>, Jun Li <lijun.kernel@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Message-ID: <20201010154646.GA248582@roeck-us.net>
References: <20201002133145.GA3384841@kroah.com>
 <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com>
 <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
 <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:06:13AM +0800, ChiYuan Huang wrote:
[ ... ]
> 
> Like I mentioned before, whatever the condition is, hard_reset_count
> must be reset to zero during tcpm_detach.
> 
> But refer to Guenter's mail,  he prefer to narrow down the condition
> to reset this counter.
> 
> I think the original thought is important why to put this line there.
> 
> Hi, Guenter:
>    From the discussion, we really need to know why you put the reset
> line below port attached is false and also make some judgement.
> I think there may be ome condition that we don't considered.
> 
As I am sure I have mentioned before, it was to handle misbehaving
partners, to enforce that the system goes into error recovery state
and (hopefully) recover the partner enough to be able to reconnect.
This is the same reason why resetting the counter is commented out
in SRC_SEND_CAPABILITIES and reset in SRC_READY instead. The typical
sequence was that the state machine would process from SRC_UNATTACHED
to some point and then stall / time out, but never be in disconnected
state.

Always resetting the hard reset counter in tcpm_detach() would disable
error recovery in that situation, and affected partners would never
recover. Effectively it would disable error recovery in any state machine
cycle which involves an unattached state, which makes me really question
if it is indeed mandated by the specification to reset the hard reset
counter at that point.

Guenter
