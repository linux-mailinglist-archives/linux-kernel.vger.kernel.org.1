Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B429EF98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgJ2PUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgJ2PU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:20:29 -0400
X-Greylist: delayed 4182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Oct 2020 08:20:29 PDT
Received: from filter02-ipv6-out10.totaalholding.nl (filter02-ipv6-out10.totaalholding.nl [IPv6:2a02:40c0:1000:1000:0:2:ffff:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:20:29 -0700 (PDT)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY8dS-000606-8d
        for linux-kernel@vger.kernel.org; Thu, 29 Oct 2020 15:10:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M+vgvBsQFLLhVdwPL3Cn4d5tDyBuq51SlsqePoH2DVc=; b=i0yHU370r3WLyvH19fjbBR53S
        GDxz6CvPymGXJ+orDduva0CoJ6yiTglP6L02fpspmBjOe/cAYTs3SMjllzQtT9irbF7LWewscVSFG
        rEPMMYuqXZ0but8+9ZE28mYn+7rqpmYKcJBoaCc+aZKV7ue6EQTUFnaf828MBdRzwohwlUqWp/wC1
        o5aWsrtQnGQgv4rI6MHCl5rRwuOLkmJqTfZ8N3ZDEQ7f6a+etaeWaQtA/MZ15Xm8N/JifVitvIOXw
        Bchf7B/KW7HD1Enn8OTebr8poofEXgwVJR+KkHo4efatW+9mdEvl7pSSlyGCssfaaymbgGUX+gbK+
        eR7BSD0yw==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:43638 helo=as06.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY8dQ-0001Xc-NY; Thu, 29 Oct 2020 15:10:36 +0100
Message-ID: <2ce68928bcec23a0f41864f4f0fb55f2dd81d739.camel@cyberfiber.eu>
Subject: Re: SIGHUP on connect
From:   "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 15:10:37 +0100
In-Reply-To: <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
References: <0e0db8180bc560c9ebaeb42957cf2ecc365cc80d.camel@cyberfiber.eu>
         <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
Content-Type: multipart/mixed; boundary="=-fAc/fejB8ek2F9WNenpI"
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
X-SpamExperts-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0QBfAh7lyK8tB8mq1asnDr6pSDasLI4SayDByyq9LIhV4BqlV4L4lMJZ
 ocNlNpGu+UTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OGY297qcBe/h6TqO9Fy9zXX4MlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJtKQMEkA/8yv655U+8w+Qo2jSUnK0zv6WWniSLupvi38VVSdplb6JAjtr1Y6X
 6/3l9/kVsZY09AACYKLhz64OUenE6wHyAbSyVXutrqMjgFKKeHGV1+GDbwcApRSCc9xvAYudz7JX
 uXFJjriWRDMOxphVVYFnQVypBB9PvvyYUf0GvhRBPk5kyv+h5d+mP9t/vCrJPmnnTHzVkpybMK7Z
 TS77fIOcTZ0QyShr1nakhTiNms8bhxfe2nIpwkiiQMh/2EOU3dkV7Fl9iAAb2pM9OvO+DA/1wzD6
 XJ7+peR66u4zj3NxBud7i94+By/iITLKmz3NJmJzTE1T6wyg1SHXC6/X6ltmddP5DwYFxEdQ5oPi
 e5mtF/tsyLRZFHqln6dZeaXk9FopelBj0dGJIHNyuOaQ/obVnu3uyesOYeEmwxz6wb3zPrzteDt0
 S6zh18eqEKu+rzRcgPveWSYyvt9+ZIxriPKzEgCjcsz4JPKUfLNDYrlSOGAmZ+beBL9cfpVPwrwu
 SDgYrg5QtEnD7MTPqZJocPi/Ms5Apjx9FDZzuUjzuvTg6mNMT+QQbxj9RUHxq3CBGnZWII9ngV36
 UqCcikWMxFkiMvu5DnwgBBUfwIN+pvlHhV6a5QjptwQBGybQSYCv8CUr7uXsVNN4cGc33wcqMaE6
 ukWs/LAGcmNGm8/KjHyDWwvFmYiG6jR/bUVAXQZW0Z2xBfF3pKxB7wQWoLSLyHiEbwTsW6oxf0Sc
 pYCpZ/x2/BpnlnZZeIVMYUTIUjC8rCn4X9EBefIGJVWa4/Y4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fAc/fejB8ek2F9WNenpI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

According to manual page socket(7), SO_REUSEADDR allows for local addresses to be reused for binding. I've tested this socket option with the WAN address, it
appears the problem is solved for both local and non-local connections.

I also found the the SO_LINGER socket option to be useful in some way. By default, SO_LINGER is set to 0, so you would think that lingering connections were out
of the question. However, an enabled linger with a l_onoff = 1 and a l_linger = 0 seems to work a lot better than a disabled linger with a l_onoff = 0 and a
l_linger = 0.

Which option would you use?

Mischa.

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

--=-fAc/fejB8ek2F9WNenpI
Content-Type: application/x-xz-compressed-tar; name="so_reuseaddr and so_linger.tar.xz"
Content-Disposition: attachment; filename="so_reuseaddr and so_linger.tar.xz"
Content-Transfer-Encoding: base64

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
AACDhtziscRn+wIAAAAABFla


--=-fAc/fejB8ek2F9WNenpI--

