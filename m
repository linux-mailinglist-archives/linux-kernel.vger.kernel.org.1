Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAED29EF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgJ2PJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:09:29 -0400
Received: from filter03-ipv6-out05.totaalholding.nl (filter03-ipv6-out05.totaalholding.nl [IPv6:2a02:c207:2038:8169::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DFFC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:09:29 -0700 (PDT)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter03.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY9YL-0001kd-89
        for linux-kernel@vger.kernel.org; Thu, 29 Oct 2020 16:09:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SH2zBHlcEe7yPIY7MBWUpKqzF6xDa6CPUc74q/Fn12I=; b=pJPmJ/s9LZ91zd5jW0trBk5Nmu
        mLIlzZF7lXaus2x/YLNrd53hhNg15KBZB4jhQFDmkKtj3Bxma6XiLEq9JxiRsV55VWY8RAtLNw82W
        PgnntkYjR4inDtjdtfm2YHvEN0teKjNQr3pSUv1zA4vcHC3C/5o5qCjv2/jPRt1VBLh66ZYuZpogW
        GlZZSUNtiCUbcOEVteWGQeSwANOUAIbtByxN/DQo98H68atfrcVVbtJWbDoKWWPpyz4ZtK0smYd6Z
        uhF1B0tuVlFzeGw6NcLJhv3FjjpTTkWuyWeN4L+5MFqqI/QReGcbIPVKYyVS4+fBH3HR0RJl1YoWL
        fPRPilxQ==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:53374 helo=as06.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY9YJ-0005kl-4K; Thu, 29 Oct 2020 16:09:23 +0100
Message-ID: <d710f7c097b960f3aa8cca9cfdba1a1f563cf3c6.camel@cyberfiber.eu>
Subject: Re: SIGHUP on connect
From:   "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 16:09:24 +0100
In-Reply-To: <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
References: <0e0db8180bc560c9ebaeb42957cf2ecc365cc80d.camel@cyberfiber.eu>
         <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.linux-kernel@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.linux-kernel@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.14)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0QBfAh7lyK8tB8mq1asnDr6pSDasLI4SayDByyq9LIhVJ448W/eUwwZo
 a03Gb0+QKUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OG8//ZPxwyJLlTXpbdJ360+oMlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJJ/fzpL1xEqFXtTRVS8F6mWjSUnK0zv6WWniSLupvi38VVSdplb6JAjtr1Y6X
 6/3l9/kVsZY09AACYKLhz64OUenE6wHyAbSyVXutrqMjgFKKeHGV1+GDbwcApRSCc9xvAYudz7JX
 uXFJjriWRDMOxphVVYFnQVypBB9PvvyYUf0GvhRBPk5kyv+h5d+mP9t/vCrJPmnnTHzVkpybMK7Z
 TS77fIOcTZ0QyShr1nakhTiNms8bhxfe2nIpwkiiQMh/2EOU3dkV7Fl9iAAb2pM9OvO+DA/1wzD6
 XJ7+peR66u4zj3NxBud7i94+By/iITLKmz3NJmJzTE1T6wyg1SHXC9sW9t3OJQkq8DzYYYHNOdmg
 Gl1aPxAtivmw3hSDPS17FkfRjQILXPzCcr3givwY/atG/1JdtNnfKKRmXtO//dRDTITIra6HuQDr
 wTqu4I+nIhDkc96CUg/BeRPoiucrOGXHsOW5uveNZyphlRIAJuFZ130p38pxLYtWprhx8NwOlbt6
 bXpgIOK9oVJzr/2NDd3kAbuVG7rVcni8TF0/ElGjiP40B7N9WKT/VzJtEIOau2HNzdpz+LC7ym5s
 BkAiwhXo00OarAnLeEfdJ8lTt/H1H/aAwarQpYDOYx/6JtUO7PDPngA/1/V34QW37TqIq16b0j+J
 oe500YUP9nmhSjvm8hwvMNv4DzXyMfB6PxPaS/eqNnCSUgKma3ZcLfAU/oH4qn6TGLoge/5Hiw9C
 lnehkIcTOMzqGiJ1kxt76RL4iLsDClfbaI84RZiugwT8QXndwcgUdq9CmjcVQOstghA=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-26 at 17:12 +0000, Bernd Petrovitsch wrote:
> Hi all!
> 
> On 25/10/2020 16:11, Michael J. Baars wrote:
> [...]
> > I've been writing a simple client and server for cluster computing this weekend. At first everything appeared to work just fine, but soon enough I found
> > some
> > inexplicable bind errors. I've tried to make sure that the client closes it's sockets before the server closes it's sockets, to prevent linger, but trying
> > did
> 
> Which were exactly?
> English/original text pls ...
> 
> And The close() (and shutdown() syscalls, respectively) don't avoid
> the FIN_WAIT2 timeout on a closed socket.
> Just set the SO_REUSEADDR socket option on the listening socket.
> 
> > not help. Now I think I found the problem.
> 
> Then solve it.
> 
> > Please do have a look at the code. It looks like the SIGHUP is sent to the server not on close or exit, but on the connect instead.
> 
> Too lazy to save and uncompress the file ...
> 
> MfG,
> 	Bernd

Oh, I see the difference.

I forgot to mention that in my setup, there's only one client and numerous servers that do the computational work. So in my case, it would have been better to
have the SIGHUPs on sock[0]. In other cases, like most cases, the SIGHUPs should probably sent out on sock[1].

Best regards,
Mischa.

