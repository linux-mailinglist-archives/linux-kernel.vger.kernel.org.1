Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6AC2C78DC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 12:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2LnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 06:43:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:36811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgK2LnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 06:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606650075;
        bh=WmcG64mDXHDk2yl6iDH5tCKMTaugBSI42q6zqWIi9AE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SKaLSxruNri45j7qzlSfrGmT4xBYD+Y/g7taC4VG+WjqY1BiPXv5SPgW47j+wVvDC
         Lzm2XMGDn9wt0S/f7/4yHlN0dChpx/oVVv9iCTKUofwVwiqCkbSHVW/Vt7o/kwch6j
         OphuoYBa27u4ociPiHb7vEqQDslbYCETa87le7/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.83]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1jwLFp12ig-00w0tQ; Sun, 29
 Nov 2020 12:41:15 +0100
Message-ID: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 29 Nov 2020 12:41:14 +0100
In-Reply-To: <20201129112922.db53kmtpu76xxukj@spock.localdomain>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sO6Qx5UM7zKOh2smiB7GRniNeoqzkU1sDc4q9DIcJP47KkzumLR
 4w/WgO7IXVVX4MFmBccAjnuPtIeRRcyyQmlAmRSe11jwJ1YXoVgtenf9OHbSurrvk95ntLx
 8t05MLPNS0kQGxwyUhPnAqwmaaDbVHgB4LCPk4SlJw7rAQ2mvmUG3jIihNTdzpAiI3i+kQU
 6IkbVFybndMVOJWiFb57Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Wn3izqMqyY=:rc4U4JxXWceknuW6uReS5M
 tzTx8P1H91vW0w2CNm1uqr9ydVTIJXeYCJX3qiAT1wrbiLddrcQT1mvVtowVLg0yTKqSHXQWP
 YBKC5qDL1aLNSxNQWw6bNUchWSCKxsKnVSB28WyEowUjXM/9JE4JY+XaduizVYxXSJ900h7Wu
 xA0zjXtILvLeybKBdS+mXPSY17DKlDXA1USy5+eJudAno7MeTiH9ZtlMEyaPMIm4ms/6Odqbt
 9ESvuJzc5ZxZDLMFBlvytyUVB3OxBUsyplNDaKx9xtomtutWCv+VCleY95/qWJGTYzNQo/Svx
 jIGJD59BO3Un0BaAfnQRGz1erlht6BDmU2H2UFhYw7PS1FGt2YFXcHXWHcXVzCPoi3YkYtMXW
 1LoQO5zX5W6QKHnHLKJQSATtzpxqY2j/amDs2xFKciluUHMPuzw0lgGitnf5o93/zNxGsbIlJ
 s/NwtnSaTNXZkvrdU+3PbcXgfsf2nDTFZ1EX1F5NkyjyQLja8EPy1bvYlvuvuqvz3KGx7iToZ
 WytlGoQGLKt6a2vwz6YfP60L0nvdV8Of/TRz50zGgAPTExk0fRK354m4jMlXZcmUHLJqRsh25
 ZtuNY0Sz6c01t4S8Ub/dKfP+9Lo9fplwrnx/edSwRFMDfokceWyzBNZyD1/amXYW901fANVjj
 1lVklPKcP0WuoLl6M1LAKr9YbcTfKpj1Q/XMeN/ckjchaRJMcBs8OApr/+qJXNL60oBzC0iHx
 IcEmezaiYf7yOZfu7TFMVFtpvlOTEPeRFcl0L0BraCg7pIgTI+7xlYlIEwceWGE0h49OoE3kV
 wy+m7tDj7AJr9Khfql2hIHgrs7pyWEufyrS6P1GyVLIhgZYwcbY7jBP7l5pK3KeszA32NGc44
 h+Wjby3EpT7JRrtTeQUw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-29 at 12:29 +0100, Oleksandr Natalenko wrote:
>
> Ummm so do compressors explode under non-rt kernel in your tests as
> well, or it is just -rt that triggers this?

I only tested a non-rt kernel with z3fold, which worked just fine.

	-Mike

