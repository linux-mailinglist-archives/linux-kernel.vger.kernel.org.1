Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31902DD9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgLQUGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:06:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:49681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgLQUGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608235469;
        bh=FWVVbi64fhOi+6PYs3/UZsujVfskYBj31w+7wUkgL6Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gDeASji/CRBScdefY3a0rDH1vf8N/M+PN6UVXnN+OXQuR0QBkgK/DfyRdSzvV+Wiz
         Euca77Kojnv+kCFykOXD1YfUYU0tFK2Uss5nM5eb6FJYG/wCS8jqOY8X+TJTl2aqag
         6Q1Gp9ROwT9esxw01IXGNH6N8MkTf1XoTP54L+NY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1kJLrX06Va-00qRb4; Thu, 17
 Dec 2020 21:04:29 +0100
Message-ID: <4b18e97788fdfcc59c69b0836b693e737a48c5d9.camel@gmx.de>
Subject: Re: [bisected] Re: regression: nouveau fifo: fault 01 ==> channel
 1: killed ==> dead desktop
From:   Mike Galbraith <efault@gmx.de>
To:     David Airlie <airlied@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>
Date:   Thu, 17 Dec 2020 21:04:28 +0100
In-Reply-To: <CAMwc25rTv0=LuAUoHqC9+Eh6rdaywwrigMza6yKbwbRiEwLZGg@mail.gmail.com>
References: <fe612bbbeedd0ee0d03d04c7341ea62406b957c7.camel@gmx.de>
         <136aa09d13fab723e0460b73608ed3950699f2b6.camel@gmx.de>
         <CAMwc25rTv0=LuAUoHqC9+Eh6rdaywwrigMza6yKbwbRiEwLZGg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nvNRRXcRWLcJnQW+LzAEELym4xWiqFu0SMrdg2Dp6VHlyGDz7gD
 2sXtQA2VcbxZvRFYnsFP3lZWuhZJG6Iss3VCME8pByuEJfvLI7d0Twmf7eHLPhCMhKPDeeR
 FXuOY4R0jgtu9jkMc+OXDaQZpVDoYclsjUtf20bOlyeC6Jt2cDIM/xkrpIxXrbNQAOhkXqe
 slddb/Xg4HC2Lub+xOcyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3diTxjBeqA=:G31ad69iCsf717rBLzPT/x
 T3id+2SsBxLwJ7czjiOq+DIIHdoolUroRxJPbrigl/FPNcatQ0lAW0kSlqxRl2UB+FQmsHZhz
 8kUOAbo42+YgI+LSENk1kvhU80cF/IsBfHGBMWKvnIgnJQ2GC9csm0Ctlv6kN9MSkui920YP4
 0r5mLv2+74eta0uo4Gqp2c5mAWMCa+1LVoB/eL6MtjtM4VQ4WRnjX/9eKfDAPRvosN97vT6sG
 QHkLZQmIYPRp2Yz30Z/IateyLW6zGoYlqBX4tlAmyjpHvGAmZR3RO9R8GTlMLWFwbXLuIvD48
 3ntQS2ETVcoSz0NyxjBx2/FlBd+8LG4Tx8Hb2MivdKHxM5o0niBqare5HQmkiRUbX0pVKX2bw
 FUcXlRLfattlWCAbKzdppZFkkMLLtHKrYlSna095QY2MJmxiyQwsHxU2MDuWDbzy23hoki053
 H/P+leVlH+krqxUFi+9wSPzwtuGRD83S97VofeZFkMtKtvr+zqI8lOqNgjABiXo2Xz0OEtHcY
 kI2haQi82WISHcz5qWOyhaTqYJSiSUEYCxlmaBKy2u9o/2giLBPz8w3IjK8NGS6PuGXKcAEi/
 UEdVoy77vvMxwRCLBgtCmnfuk2Qg2JgtX8Ahl1W2dnZ2hCtr6jTsIFNg2JR2DTwTLqQNDHeJP
 zRjsuMeTpz4aZ3JYvHjT6/gwvGKZsFpOq0LIhsp4m/ynjPI1By8SewYBx3kz+qgcxauoieISS
 nbmxsaAXp1x5ELyoUoTt6c2x5Txd3VTqjC77GF1niM/+w3AKNoVY2q62rI2fROGOvRVJUmlC7
 GuSEhp53jwZrfje0a19prKcWSStnrul6a39sf7rGu3XtoxbJY0xrutf4gFuRI00oQz8OaWYrx
 ZkZqurKIqno5lkUsgFKg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-18 at 05:45 +1000, David Airlie wrote:

> Does the attached patch help?

Yup, that seems to have done the trick.  Fast bug squashing by the drm
guys today, two slowly bisected, two quickly squashed.

	-Mike

