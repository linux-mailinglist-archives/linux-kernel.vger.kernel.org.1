Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA529829F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 17:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417400AbgJYQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417393AbgJYQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 12:56:05 -0400
X-Greylist: delayed 2650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Oct 2020 09:56:05 PDT
Received: from filter03-ipv6-out05.totaalholding.nl (filter03-ipv6-out05.totaalholding.nl [IPv6:2a02:c207:2038:8169::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B976C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 09:56:05 -0700 (PDT)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter03.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kWica-0004TL-Et
        for linux-kernel@vger.kernel.org; Sun, 25 Oct 2020 17:11:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:Date:To:From:Subject:
        Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cF0HIGN28GyOCfEKW9d6an28CgJ7xqKA4o1rI7YxNT8=; b=mW918tJ5M6wUOcU5A74ssxhZdT
        WyCXnK2xQQhPwMayFjKaNnmbUYnf2NCYv/9AA4bQJAczCLn8mYKP97SJhNRdUS1+tQ7iNNhnzu6y8
        LQpByUBNRI89tUv3Z3cVTpwrgLIfvWztCuliB0iQxWA67irwIxjILPCJYt2Y5dLe74tfpcrHIGU3b
        ixNvBAVO+U8SvuASdVDzhoGMv7byrfjVl1HGvwEwawI76OowD7xvYJE/7OSKAuWMSMtv4/aZKKQYm
        g7oUXxaeLEmDWsK004cL7eua7F7z2Qtj3T41YPfHKJxoODROeiq3U9aI6SKQgi0jAfDz4WSmQNmYT
        kfU2j3rA==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:50566 helo=as06.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1kWicY-0004CY-Cl
        for linux-kernel@vger.kernel.org; Sun, 25 Oct 2020 17:11:50 +0100
Message-ID: <0e0db8180bc560c9ebaeb42957cf2ecc365cc80d.camel@cyberfiber.eu>
Subject: SIGHUP on connect
From:   "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     linux-kernel@vger.kernel.org
Date:   Sun, 25 Oct 2020 17:11:51 +0100
Content-Type: multipart/mixed; boundary="=-olNjd5WSgopV0Of1NAFB"
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
X-SpamExperts-Outgoing-Evidence: Combined (0.21)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0QBfAh7lyK8tB8mq1asnDr6pSDasLI4SayDByyq9LIhV4mjo9ITq1Wf9
 HrjNpICfQETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OGi3GhA0mXMaXSIJ89Y1KILYMlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJJ/fzpL1xEqFXtTRVS8F6mWjSUnK0zv6WWniSLupvi38VVSdplb6JAjtr1Y6X
 6/3l9/kVsZY09AACYKLhz64OUenE6wHyAbSyVXutrqMjgFKKeHGV1+GDbwcApRSCc9xvAYudz7JX
 uXFJjriWRDMOxphVVYFnQVypBB9PvvyYUf0GvhRBPk5kyv+h5d+mP9t/vCrJPmnnTHzVkpybMK7Z
 TS77fIOcTZ0QyShr1nakhTiNms8bhxfe2nIpwkiiQMh/2EOU3dkV7Fl9iAAb2pM9OvO+DA/1wzD6
 XJ7+peR66u4zj3NxBud7i94+By/iITLKmz3NJmJzTE1T6wyg1SHXC9sW9t3OJQkq8DzYYYHNOdmg
 Gl1aPxAtivmw3hSDPS17bWb/KKS3KB2wElk9OA4lOqtG/1JdtNnfKKRmXtO//dRDTITIra6HuQDr
 wTqu4I+nIhDkc96CUg/BeRPoiucrOGXHsOW5uveNZyphlRIAJuFZ130p38pxLYtWprhx8NwOlbt6
 bXpgIOK9oVJzr/2NDbbNP+gdHebIVrd2PJGCFq3DJOOhrbJEJQpEtb1BcaaBu2HNzdpz+LC7ym5s
 BkAiwhXo00OarAnLeEfdJ8lTt/H1H/aAwarQpYDOYx/6JtUO7PDPngA/1/V34QW37TqIq16b0j+J
 oe500YUP9nmhSjvm8hwvMNv4DzXyMfB6PxPaS/eqNnCSUgKma3ZcLfAU/oH4qn6TGLoge/5Hiw9C
 lnehkIcTOMzqGiJ1kxt76RL4iLsDClfbaI84RZiugwT8QXndwcgUdq9CmjcVQOstghA=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-olNjd5WSgopV0Of1NAFB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I've been writing a simple client and server for cluster computing this weekend. At first everything appeared to work just fine, but soon enough I found some
inexplicable bind errors. I've tried to make sure that the client closes it's sockets before the server closes it's sockets, to prevent linger, but trying did
not help. Now I think I found the problem.

Please do have a look at the code. It looks like the SIGHUP is sent to the server not on close or exit, but on the connect instead.

Greetz,
Mischa.

--=-olNjd5WSgopV0Of1NAFB
Content-Type: application/x-xz-compressed-tar; name="sighup on connect.tar.xz"
Content-Disposition: attachment; filename="sighup on connect.tar.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4B//BTFdADmaSRnK6U5KMpWMwY6NzPfzatMt7eQ0GCBd
xkjQyeavJsjgVwyrXCVsmMwvzkNpheFMDxI5furPxB0uuIU7sIQ8Y2No0ZwFpsAlRh4qTRbGRBgT
Ec/VTyRwHNaaTOvnvvOr+W1I2/ck7i2Y20NwUeldd5DOVe9lfRyYJsuNvzvMhj7rbFGRK7/HHbhy
obfPHvq8l9hKQ9W+B8MT1YG55tSowy8MM17y0h2pyUE/vuZCbyvQYr/1tpa3E/Vcs2qe3ONP3+WE
Qk8GVy0s8kAQqY9sbJSFHqSNx3nDBbd7VNeYp32oIQ/zPql9Jkd8py4moNKh1KpExXxFZLFtVOOj
prKi1WG1PazHgKqUjvnpfajXkf3We8eIQpByLTXMKNAewp8ModvdwrkWgTFfwzRktBusRdfN0h0u
AIXQ+If9JbHmJKlKrk96AMZ5x5X2U1IPSy/JtNDbrdtqFKRIIWAIiiGO5l2BmrT+Am0EVL0ffgsS
XbmbGN10cEjDr5+eIYTC267ctlTYHArxke4NMAsPi+r8n+D8LsQGzpDA+/DJh5p9xdHq3G4mbqBg
KtxqJNkC+zIfrNQ7XGgSFX01IawJhdZWuBW3Vse9+j9utSVrpL5jAyJWsQuM86ZeQ94Pqu2hB4XA
c/mXEJvY/+E9IFHPaVDWo/lDPBRjYCx9GCbZ/VFfO58K3QXTBKNmm9K+eCv/ezU9Dh3iqngfepbb
udQwcNw61e/b0aXNxSOkSfW5+a1AbWLUqjACa+xr7ZTsA7ftrcEKK4VGKMLnXxW/4eXtW+lWrC0w
/3/2YrEGDo8mXZFYt5wMHxWckjNovT+MJJ7jOXt1qoJVwpMXvOMSuLa5tfApx45b1w4MmniWztfk
VVR7iYgegAkBJw+ZS3rtRKCEePVUDUR09Hk/QANB6Pz5GTuG6CBSqhmU378CAYOISbgK5+cOHKZw
dzswZTDxyGLLPYB0/jrz1szZw+95gk7076Nds+WOsAOgzdmCVkq/TneOWoCr8cJHmraGZ/TCwPSm
pNtUYIolhOQw2MGbhN8/4BTBngA91W6SuZITWPLUHjoOwh85tHIP2t9tJXGpU9ekyo+B1d8A0yYM
IhyKiM+9xUCxDEFu9C8GW2Mp20rFZQ0YgwHRR2isOlrBFjDFQX3SrvhGWx6EVGRSFKIkvsniDw3O
oW72udjqsfoc4QkgiqZzfKmXrkjFsWMfp1OKj6IG2O1hICn0w8qakcBXPf3bNveHqddBRh6tsDSq
v18UGg7t5uNtFFMgowc3L+qQBdBudlT8Z25MbcDybUDey+TvRZH9tUbs+UVWsLHohQ/3mJwd4YwS
TOUQDpuucEBR589tPng769Lx/B1OKNZlGqkjgWa0QArBz0Zu+cFPudLj9m7CdBv3z7LQizydrHU1
UIKwKSGRms32Dg0J4kSZ4cpDRHLE2GdkCp/D3XFQuVkRhGYmn3oXq3DA+pjBqeKm95Ta1R876BW0
r1OtJnZ//86yBxt7M5AH3wPEY6fhuXNudlyWM6u7xbhFh6XnD0gZ6byfJSQwgjXRul1DZGRDj7/C
F3IRdDOsyNFi9wgm9/I7W+PYISPQubHfc9SwU1xNKE0kSAsJcQEG/qlLLeVt8bvOuijvTNW/8O+c
8cplu1zphAc0aUrdMJyDYCBw6PYWfM41m/LtyIlq1SYKWI/AiQYHjVyLSZZF+NwdWflPaEgfmNSC
u0oCzJ5oRlVMtCmew/eTqipidCV5X981SE4cHJsOo4qjFK3sWt9wyyOMbIE9MMYcAAAAAAAGvc1n
0gnrWQABzQqAQAAA7fpQubHEZ/sCAAAAAARZWg==


--=-olNjd5WSgopV0Of1NAFB--

