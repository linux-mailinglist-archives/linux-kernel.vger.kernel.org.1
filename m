Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28352DC245
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLPOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:32:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:54813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgLPOco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608129069;
        bh=2jyEv3qgNqQilJm226okSZdj9maeO61pcUjpdKq1hZw=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=PBwHL2KPGHv+qZKSghCn+exSfauerWHPYJGqD4L9lBcqyCUAvj9i24XnU4uQh9RSa
         xFvw8SRT3Tird9EG/8VcjDaPRlHOazThgo6P83pJOOjuqenAz83kgo1D1kQeY6QqYC
         X00Wd05BTJVJSxJAk42s8qWWSLqtYktPatGPB1Ro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1kHaaf23Ii-00aR7h; Wed, 16
 Dec 2020 15:31:09 +0100
Message-ID: <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
From:   Mike Galbraith <efault@gmx.de>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Date:   Wed, 16 Dec 2020 15:31:07 +0100
In-Reply-To: <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
         <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
         <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
         <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UajaVc1oxya0dY2+2pkATNvejcVBW3YDJa1eg/fBMoh1fQRNg99
 XsSndfMb6SesgWa4xpgW0zyamj1KcAHm+/ZQmRVHVGG9jC0LK3cPoGN16XLsByn6yWLCv8d
 4rSvJASlDSPxccrWGTQmZYIVImr8g9n7/m4g/A3C0aFSbyJXgwlmU0mYADoLfIwLswT22SO
 4y9eDT5Ls1PD9Q4Q2Bdzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9S/GW+3yx6M=:QesAjsfqrKxVEvKvmz0hpN
 iBv3U19PekKVuIlB47SLqn4BJpggqzdePT1r6LrJXNI1pa8IYC50fXZz7sFgnPP8yqr52a7LK
 ol1JMTJZ++9suocwUBKUi8rtrQTvkrBF13ECzpQH9QO2l3WMPUactXTW5BfW7uQ9JETEEI0Lb
 finW9J28b+AhFcUqh/hdRHKeIKlaWc7uGky4CQ43amvdnlY1W8IAU8nTY4EmFdpwQs25VegQb
 VAs/y2YfvlgyJTaCgzY+ToSgCNLOE+5E3N/HTb7HGvUDfyQ1ghUe9w6c+la7l+zLqOI4u6s55
 aderfG0Jlf/MX4Q6zjmkEdcN9atwUbnUsbQkIvlBWhqOPil/i2R/nuWMUF3kkkxdxw2Di3Tpk
 zZ+wXXnMINwQqCABvaalulIPm4AEsdjgKZdzV1f6JBqa3QagFsOIIL2/sjP1KZ64Jl9woJ/eF
 N5ayXTEucA0BGSUcd1Psa/xgcHXu0L8/bzuUWVEW+SRfjqKaXpMCTkQnM2yPnH3EYxCtMKns/
 PMMYHV2hzewtqhSdy5tou78NhFzCjWySet1YP7G2/KiSc81bJweD8mVjW4d+hoOFcl8+K2WP+
 YCG83SRoWze+hNYGb8Y/9OGXq/4NfygtwYtu7J3C0q8QuBAycaypOw2gw9AFEFtYfF1QFlfDe
 Xzths3kqnCPMSptqXKq0cjZ+E9K1X0vU2bh919gR4tRbAvgnamrekRmHEpYVAfAUckf5cXObr
 F0ZoAe0xrz2MjAVVbuDkxUN1cmVrdcm18bP0mGGn+1igXOVZlKgEe2VGwKqHaVTSzM7GcVg1O
 66t/Va2b4NeoUlV3LQHHWTJvKua5Wkmc7aW09Y7mFLBpmHZ0JCSK9l6PN26e9qatXlw9P3s4M
 FtuIrkOntxg2J0ZR4GmQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-16 at 17:23 +0300, Kirill Tkhai wrote:
>
> Does this regression only cause that one error message "check_release: C=
an't get the kernel version"
> is printed instead of another: "The kernel version is not supported."?

The thing does indeed mutter about the kernel version, with or without
9a56493f6942 reverted, but it work despite the muttering with
9a56493f6942 reverted.

	-Mike

