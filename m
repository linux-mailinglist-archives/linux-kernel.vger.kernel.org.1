Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AEE1A6821
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgDMOZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 10:25:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:41043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgDMOZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586787920;
        bh=unSxpRsDMlSBh+KoqlcyvwQe1MQ6kpwfYI9Sofambco=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KSKUCpzMYxIDjfTfAXxreQwd8mrMmlmXg5LToQ+gbJUTfOu+uaTgZhjRykAkrsYtf
         JJVUHiUGuDIJLonU38hHVdjlEOugNHKVOyYv+dEZea4RajEls9Z9R30YOiTQdAaQZb
         VgceuapE7AidmTxFQHO0iv5Gp4RTovZrkKqFkIb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1jbw6u3ZK7-00MuTb; Mon, 13
 Apr 2020 16:25:19 +0200
Date:   Mon, 13 Apr 2020 16:25:17 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
Message-ID: <20200413142517.GB3101@ubuntu>
References: <20200411122610.7901-1-oscar.carter@gmx.com>
 <20200411122610.7901-2-oscar.carter@gmx.com>
 <20200413125616.GA3127208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125616.GA3127208@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:sePqCH0veJcZP+UIPEJ20g1Mqu5U4j9dYnY8IkxX8Q47yMA7N/8
 Wy/a1qW5CHeJCk6ifgR5vVx2PyXdvmAfWxZDj4gd/9c8rBiqy+ao1FhmoBa3HhQCOa28/s8
 dFFGhHn4Gs/vk8ozR41que6OktruwYTZcr64xHy16rB7Js/Srj3fq/2rUZFxW6/ai5+g04U
 yBh/g+Fau6fxGBmwbhqMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wRIMaxwNqc=:hcxYmiiQ7Sp467P4jDYvMO
 9xiS2Jevx9BkqYY5WJUDUzDiFTSa/K68mp5bPWOzNaq2RuAzq+D5H4vVsgGyLmzih9uRqtmkb
 1qbnc1ojp0rYNkenfRSgKPGixOZmc6IaxfaHp+eMA4dDY7ZWEKTXPpBcvnLDGMiORt3fCgHv5
 /t/cKyRWMaoGOPRBRMwc5M51ULkfLSs5lZRdfYbrxAnbOImcaNZViQ4KPBlR7FXprTSZTc8gK
 /sH7j8Qh4bT/PoZh3cZl9mw6PKpsVrtUQ8SASmH8/Iv+tW+qmeyU0aqGeJCL2Yx5REUiHN4W3
 G4J/Xw1XdZT3r7NARiBJqqQwPRWg4XL6m+lBWtmXr/E9SPCCvFkldXe8HRR9dmFE4gsn5CvGs
 n8qNcH8aviSL5eKxYuhnFM99eyJN+zF+BRI0UQVKyK7hG49Q5i06bd/vHmS31pZjDDz3lxnGF
 mqVIAuyKcGCtoLiEOoOLfD0RPIRsAPZlbrvso8PuAfvlTmJ2n+4h62nmF/IF/nOQYqESX1QMG
 0A0/zp50tSdAiWnTfpo8rseW8lSGahkQR7ABJuvWsqNF7Amsyd7hXuXsmjlkezXEsbbUBdZpw
 uAGCkTC3UeQA/y8/g86kpL0QeP2v8XsZNg8Q9/AjzFJITNpbmh+c9hspE31swIQy5YY/7hqW1
 VTwbSz+Q61cx5nQ2QCvOPzDxgUl2HV51p/+Ak9GuqBANj0rCZehRl4itkElk14WomNjVahYQf
 wBbdcPUEllczahbWu4j1HQkYWEN7EvZqt7oooDQf1FPrqeOymYaB14DP9J0S+5n513uR4zKV2
 kZ82CuBpt+vTJTKQGEvArwwwgsmdOC71AmiyPpk1du7Vqo52QGEklb9Q3BRWeAoKQWVz7V4mw
 uvTITLacjbP4C47G0M7gRTqPbL8fvN3im7iCLKp8f06Ekt+NaYg7VwJHuIXfjVduBC4ZgVTHm
 Zl/5RFWoG0fL9/mx2p81AvV+4Mw3wghmOxEPaz5DKScldeKo8AqhJbg/9C+tovnPOG0TPT5Vp
 Q+gFBEaHxq3+QZq/E2aAo3x0NHBfD53GInxm+IMjVL42IURkkOUvOQS68afXjNn57j1sLM8/Q
 gAZPnfAWaz2hD5Kd9KZuEQLGtXiAjVYSnTTXPZUWnr2jSKuBAhiODe/i95kg0w/BOgD6qSoyN
 OzzsvtqQt/V97nPtuQdDJPHU01Bur5UyPMSOoW4HKWqq1PF8PjhoOH0ADdhu3RarPU62MpApY
 Y40pplkhJvTTzDcQc
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:56:16PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 11, 2020 at 02:26:09PM +0200, Oscar Carter wrote:
> > Create a constant array with the values of the "phy->signal" for every
> > rate. Remove all "phy->signal" assignments inside the switch statement
> > and replace these with a single reading from the new vnt_phy_signal
> > array.
> >
> > The constant array can be of one dimension because the OR mask with
> > BIT(3) or BIT(4) allow obtain a second value according to the rate,
> > the preamble_type and the pkt_type.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/baseband.c | 105 ++++++++---------------------=
-
> >  1 file changed, 26 insertions(+), 79 deletions(-)
>
> This series did not apply to my tree, please rebase and resend.

Rebase the patchs is a normal process in the development or am I doing som=
ething
wrong ?

>
> thanks,
>
> greg k-h

thanks,

oscar carter
