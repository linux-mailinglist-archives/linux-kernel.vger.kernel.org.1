Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1F2A07BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ3OW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3OW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:22:59 -0400
Received: from filter03-ipv6-out05.totaalholding.nl (filter03-ipv6-out05.totaalholding.nl [IPv6:2a02:c207:2038:8169::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:22:58 -0700 (PDT)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter03.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kYVIr-0005aj-B4
        for linux-kernel@vger.kernel.org; Fri, 30 Oct 2020 15:22:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7/2pb3PekncDyTm+RZ5+ncI/72N47jqAulFj4Sdhl2k=; b=b7EFy7UBhbREce4QG2sy+9Tnh
        anoFaIMQMETZwfwOhQvRMql4gu3FG2pzw4TdHz3GSsf+PMfeAOoJVyyL90n+Pua/+ZA6UZHSjY3Ja
        ead1ZZrJHUohzDnlM9mXAvdqp0nJPCXrMhn7Uk0RkTEPaooM7ntIMvIC81txffNyR984fOvjy87du
        oUS86n0S+Ngu98v0XFYscX3QMIhvmWKirZLNoJgacOtflbKViCCZM03V3QGX1Y5Y4b6yn+wHSHO3K
        qWHlthw/UrFVohbVKiAL7WwiI43hvgEn5L7pOgdWLpD6HI/X6jMQFW2c4eTAhgFr5XOKqz/VTS0E1
        OA1x7TRmA==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:49222 helo=as06.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kYVIp-0007j8-15; Fri, 30 Oct 2020 15:22:51 +0100
Message-ID: <af7cc60da6ee12a870c9a4a7467cda6add89ef99.camel@cyberfiber.eu>
Subject: Re: SIGHUP on connect
From:   "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Oct 2020 15:22:52 +0100
In-Reply-To: <c47a429f287a0a085a54483df0994fae58d4c356.camel@petrovitsch.priv.at>
References: <0e0db8180bc560c9ebaeb42957cf2ecc365cc80d.camel@cyberfiber.eu>
         <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
         <2ce68928bcec23a0f41864f4f0fb55f2dd81d739.camel@cyberfiber.eu>
         <c47a429f287a0a085a54483df0994fae58d4c356.camel@petrovitsch.priv.at>
Content-Type: multipart/mixed; boundary="=-yKNsiC9WNBngOp9I0rJ9"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
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
X-SpamExperts-Outgoing-Evidence: Combined (0.27)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0QBfAh7lyK8tB8mq1asnDr6pSDasLI4SayDByyq9LIhVBoeDRKxkLvir
 l60W1uawa0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OGPXxNbpPplBB5vA/Kmor5m4MlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJJ/fzpL1xEqFXtTRVS8F6mWjSUnK0zv6WWniSLupvi38VVSdplb6JAjtr1Y6X
 6/3l9/kVsZY09AACYKLhz64OUenE6wHyAbSyVXutrqMjgFKKeHGV1+GDbwcApRSCc9xvAYudz7JX
 uXFJjriWRDMOxphVVYFnQVypBB9PvvyYUf0GvhRBPk5kyv+h5d+mP9t/vCrJPmnnTHzVkpybMK7Z
 TS77fIOcTZ0QyShr1nakhTiNms8bhxfe2nIpwkiiQMh/2EOU3dkV7Fl9iAAb2pM9OvO+DA/1wzD6
 XJ7+peR66u4zj3NxBud7i94+By/iITLKmz3NJmJzTE1T6wyg1SHXC9sW9t3OJQkq8DzYYYHNOdmg
 Gl1aPxAtivmw3hSDPS17NO9HdJC214j/JVELVUkR1atG/1JdtNnfKKRmXtO//dRDTITIra6HuQDr
 wTqu4I+nIhDkc96CUg/BeRPoiucrOGXHsOW5uveNZyphlRIAJuFZ130p38pxLYtWprhx8NwOlbt6
 bXpgIOK9oVJzr/2NDSTmWBgStbRbqatAKMOg3gDcKvpH0FCfpzqf6pVE49yQu2HNzdpz+LC7ym5s
 BkAiwhXo00OarAnLeEfdJ8lTt/H1H/aAwarQpYDOYx/6JtUO7PDPngA/1/V34QW37TqIq16b0j+J
 oe500YUP9nmhSjvm8hwvMNv4DzXyMfB6PxPaS/eqNnCSUgKma3ZcLfAU/oH4qn6TGLoge/5Hiw9C
 lnehkIcTOMzqGiJ1kxt76RL4iLsDClfbaI84RZiugwT8QXndwcgUdq9CmjcVQOstghA=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yKNsiC9WNBngOp9I0rJ9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Here, think I got it :)

Just run 'make; make run'

Thank you for your help.

On Thu, 2020-10-29 at 21:48 +0100, Bernd Petrovitsch wrote:
> Hi all!
> 
> On 29/10/2020 14:10, Michael J. Baars wrote:
> [...] 
> > According to manual page socket(7), SO_REUSEADDR allows for local addresses to be reused for binding. I've tested this socket option with the WAN address,
> > it
> > appears the problem is solved for both local and non-local connections.
> 
> Yup.
> 
> > I also found the the SO_LINGER socket option to be useful in some way. By default, SO_LINGER is set to 0, so you would think that lingering connections were
> > out
> > of the question. However, an enabled linger with a l_onoff = 1 and a l_linger = 0 seems to work a lot better than a disabled linger with a l_onoff = 0 and a
> > l_linger = 0.
> > 
> > Which option would you use?
> 
> I never used SO_LINGER before.
> 
> From the description in `man 7 socket`, active SO_LINGER just
> makes shutdown() to block if not all data has been transmitted
> (and ACKed?).
> close() on a socket calls shutdown() automatically (unless
> the shutdown() has been already called).
> 
> The timeout which you're application runs into
> applies after shutting down/closing the connection.
> 
> MfG,
> 	Bernd

--=-yKNsiC9WNBngOp9I0rJ9
Content-Type: application/x-xz-compressed-tar; name="so_reuseaddr and so_linger.tar.xz"
Content-Disposition: attachment; filename="so_reuseaddr and so_linger.tar.xz"
Content-Transfer-Encoding: base64

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
t+KxxGf7AgAAAAAEWVo=


--=-yKNsiC9WNBngOp9I0rJ9--

