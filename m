Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1229EF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgJ2PNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgJ2PNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:13:35 -0400
X-Greylist: delayed 1124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Oct 2020 08:13:34 PDT
Received: from filter01-ipv6-out02.totaalholding.nl (filter01-ipv6-out02.totaalholding.nl [IPv6:2a02:40c0:1:2:ffff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF8EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:13:34 -0700 (PDT)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY9KC-000441-Du
        for linux-kernel@vger.kernel.org; Thu, 29 Oct 2020 15:54:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9P0zdrcy5Z2/uqjSEDki/45YtRCSrecYAJrSY4aTUJ0=; b=GaSWyu0siRSBEEfCdIqk0jPc90
        h4XCw4xqVw9UCoSw59nuuc1PO2M1R5wEmiw7EOnbu5V5SKGGMB/i6LSC6HJ5qNPCN8yKmFldUBrCX
        sp7ylAO6vkQaz/Ys1HEldqx0LSY6j6Zx1VPjTzOmPeAes7Z1eCCJStF+RxiJax8AtpwHp8tpWHpdy
        tih6h/yXyh8+2+kiF1IlVnzomJyFiudiLVbQBngzhzqJwdSECre7uA9RyM0jTyyIDbeorwVblv9cc
        sDnxahWw3Uj0aCs857pa44RKPkekEuamEpisBFNbKGPm5QoqQQhJ4+/NGMmNp5lYZnH4ycSZuj7Cp
        sQhqkuTg==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:53334 helo=as06.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kY9KA-0007sV-Sa; Thu, 29 Oct 2020 15:54:46 +0100
Message-ID: <c4bc7e51f7daad7cf9e8933137572c2f4c5ae6ff.camel@cyberfiber.eu>
Subject: Re: SIGHUP on connect
From:   "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 15:54:47 +0100
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
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0QBfAh7lyK8tB8mq1asnDr6pSDasLI4SayDByyq9LIhVnzHRCz69YIZK
 3+VycIlAqETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OGaRWmo4NNhthkrH4DNlUH0YMlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJj1pqXi8btQCfqom9tO+O5GjSUnK0zv6WWniSLupvi38VVSdplb6JAjtr1Y6X
 6/3l9/kVsZY09AACYKLhz64OUenE6wHyAbSyVXutrqMjgFKKeHGV1+GDbwcApRSCc9xvAYudz7JX
 uXFJjriWRDMOxphVVYFnQVypBB9PvvyYUf0GvhRBPk5kyv+h5d+mP9t/vCrJPmnnTHzVkpybMK7Z
 TS77fIOcTZ0QyShr1nakhTiNms8bhxfe2nIpwkiiQMh/2EOU3dkV7Fl9iAAb2pM9OvO+DA/1wzD6
 XJ7+peR66u4zj3NxBud7i94+By/iITLKmz3NJmJzTE1T6wyg1SHXC+qhp9RT5G0wusc+IPfSptSl
 0d9Yhbu90B+Wde10vNHoOupDGKKnXV2CsGPhJrm6JBwgt3IXw547hSAljLsS0SzspzcThvI0WhrT
 Q5gC9vVo0NgnI+VXGqLAI4CfeUghOJHplT28bUCirpThtdrNNKc9PcYcygy7Yq6uOxJFhLg7Hw0N
 A06pEmkBoZo+quTIb8jKKkHlvQCrvKhEfgjfauqZZvTR7IqRawW+jKgJ+0SpS7dWV9hnsI5c2D3+
 n6sWxJtbJMS0deRxVbTK8XkuTSEk5ggl3gy9DQ1/gRxu8c7VW5L72jdqaONUbd0NgYO/7LDmrTAQ
 HCeMVKXljv9zJsNkzezd+hAAzj19oyb9EcBmWwSmiaOx6wHHpgSXIqydkA4v/Eq5jOZTOkrJkzEs
 fMsgDr6SwmZZQLIhkHYqT7xiq+51PHPhd9K3C4c+XhT1jjEvuGslKTrRIXcXpFg5ivY=
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

And I think this was sort of part of the question:

We have on sock[0] serverside 1 SIGHUP on the connect
We have on sock[1] serverside about 7 SIGHUPs on the close

Why not sent these 6 or 7 SIGHUPs on sock[0], such that the SIGHUP handler has to be installed only once?

Regards,
Mischa.

