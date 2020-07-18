Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FE224E08
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGRVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 17:04:04 -0400
Received: from delivery.mailspamprotection.com ([146.66.121.9]:39131 "EHLO
        delivery.mailspamprotection.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgGRVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:04:03 -0400
X-Greylist: delayed 3006 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2020 17:04:03 EDT
Received: from 139.106.192.35.bc.googleusercontent.com ([35.192.106.139] helo=c64941.sgvps.net)
        by se26.mailspamprotection.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <garyman@mazegrass.com>)
        id 1jwtDW-00038O-T4
        for linux-kernel@vger.kernel.org; Sat, 18 Jul 2020 15:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mazegrass.com; s=default; h=Message-ID:Reply-To:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1JtLabPY5Tapq6SNsOmj6yBCUWLIFTlOdR00nT1MsmE=; b=BtzXqoG2D7GUMA5U/el5NRX6eL
        iIaFHW75XiQB9d2eIIBySYr/jJYgS/cLJ9qCFZdhY9EjihNsyEnWcOJBo3mffDSSWGVhn4darGaOV
        WcIveQ3gHLMumX12hHgzxVd0G7lMOJaS5gEmBNPLtVeKt+VJmKoUX1mvQzh3B8CzCgqXHW1zI5+UN
        KsyWnvVvwvSdS+1bnUdijpHSnr1AlY26tfdrCZKtgRdnIJOy6VuhbAqibPXaUMygct4eCSpp9RuFa
        qzvppx6y2C1jnnR0upDD+vISKDG4jrBGo5BYTzdAj/TF1xmRM/8mtzKBtz9L7EQy0CzzzQn2HeaS/
        ExCa01Bw==;
Received: from [127.0.0.1] (port=54648 helo=webmail.mazegrass.com)
        by c64941.sgvps.net with esmtpa (Exim 4.90devstart-1178-b07e68e5-XX)
        (envelope-from <garyman@mazegrass.com>)
        id 1jwtDW-00005q-Fj; Sat, 18 Jul 2020 15:13:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Jul 2020 15:13:54 -0500
From:   Gary Mann <garyman@mazegrass.com>
To:     undisclosed-recipients:;
Subject: Your Message
Reply-To: gary-mann@contractor.net
Mail-Reply-To: gary-mann@contractor.net
Message-ID: <9acbc91e86547a5c1a8a61977a0f471e@mazegrass.com>
X-Sender: garyman@mazegrass.com
User-Agent: Roundcube Webmail/1.2.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - c64941.sgvps.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mazegrass.com
X-Get-Message-Sender-Via: c64941.sgvps.net: none
X-Authenticated-Sender: c64941.sgvps.net: 
X-Originating-IP: 35.192.106.139
X-SpamExperts-Domain: c64941.sgvps.net
X-SpamExperts-Username: 35.192.106.139
Authentication-Results: mailspamprotection.com; auth=pass smtp.auth=35.192.106.139@c64941.sgvps.net
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.88)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVaaYvLuuNqJmo
 DS+hkP7YlUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OG4iQn1c1KmEFjJA75Kp43LYMlhcTgOXSCz8qb
 ysTVYVmrsnknpbK3sMgY9Aimwh4WNbVkGO29bCBdLn/eWIezcIqVTQMpsQhzL/dzw4izUWuXwxDx
 u8eqQSrZ5G4OQQPJr30Gcd7n5aFFZFfMQdpTpwT9fL1uqHa3zvHAM0nVlCdxXQE4zT0wGzhcNT11
 IXQvV285Rg4HPV7XsztaaZW8YBkhzVJFWn887ct0NFXnFWKxnGmiI3p9NEdyvIai1RA3FPo67MED
 uAALBU22yFTfTrvatWWiSP0Jxll7g1bGZi0vEeKBjl8pSptg+BMMiNnKvkLfKpnONMilKDpiwWQ4
 4xsM51Mye8eo6Y/hXEFbc9MIm4qZ5/UkJuZ+By/rOgnAF9+F+UY+ivyfK3x+QUrytWzTUqu5rEHq
 zRojuZYvEWorQdP+Ck9nZ/PFblLUzXTP+MEYMo0NDeyXVO3tNSgVgckOnz0mswVXZkpFVe5ZgGA0
 MLjqgL337Aba0izaNK+kSmv6r4bv9PnBlF6hC7KCfdJub/qkhntF1gtJuAeJQPO70McBOIbAW20E
 4csnX0ITYu8C5mJ57ZG9g9QfbBpIF5Z04yWfZLgQgdzVeXR/bLnRtFuayQSHKxuVs+RmqoRqPWNf
 geTQJflIilvArlLvnLAgWuFgLFprquwBx7gtn+HPcWP2tTPjYyzllDUYH2J3DSV9Sm5t5VvTRxiw
 uPCqV9OtJB7DjrAubdHMBZozYJLI5MBpLyJ/c3JaAnkr8S/bXPWlFdaGOH191uXjgjQN/bcQLNqO
 ofGlQDttWG3wwpPBTLENJHtUQltaKHdeuPsETfBam4aUH0McDbI/agpjyJteUXJlFvBtdpSX2ReU
 TNPeNHk15VolAGHS5rCXQKDysRlSe5ch31WOzCnRYd2OakVyo2F78CtYo/Ow63Pn+4EONDOYJuk0
 fZhBkVLQmn3OuLed1HSgYvWwN1u0oPGWRscqVIVmew1f0LYVJ+ME4xY=
X-Report-Abuse-To: spam@quarantine1.mailspamprotection.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-- 
Hello, I am writing to find out if you have received my previous email 
regard a business proposal. please get back to me as this is the second 
time i am writing you.Thanks Mr Gary Mann
