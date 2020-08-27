Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D912543B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgH0K2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 06:28:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0K2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:28:43 -0400
Date:   Thu, 27 Aug 2020 12:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598524121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTklcD731Fi5e0+Pn8+aeun1glrmN2Z4cLid14mp7hg=;
        b=jvRB5DRS73xHplCub+07++kcQR/4YFSUqp48DlhPDSo5Naa8XEygsQQA7RRAh39vwlJArD
        VNGkkAn8N24D0Qk+MKBTywdtSXjgC9wpeqBYJdLorlVq7XYA8o/2LXEOko+3vonvb1mutZ
        3KV/6S8mTPn/yliJLpyxe6iIB2aOoF3Gfcn9WL1wA5u4R2+an2ZSn8dMXHmL3605LiYzgh
        jZWnJZz807XqvlNGEIC2QAGlGqwgte0C0N0rpNvGz9Jhlpzvm4aEFc4lz2UOrFYJ8qHj0s
        PASVOwBgsLygORknoefvtdUt7dSHQGExa+JEC19VNPuKFnwGbw8WHvknjAFi6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598524121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTklcD731Fi5e0+Pn8+aeun1glrmN2Z4cLid14mp7hg=;
        b=jsDsEYmc+jw1ktijJrmJ3LNXx66BP0w8X63N1xyFq21A/D+B+J7LWkw0uUbNSqY7g9K/QZ
        TgpOXxFPCZx6xZAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827102840.msv556nrah4h4vmq@linutronix.de>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 12:16:22 [+0200], Daniel Wagner wrote:
> The -rt kernel is roughly 6MB larger. Just need to check the memory
> ranges u-boot is using.

so that 6MiB sounded bad but then it is ~36MiB in total so=E2=80=A6.
Is this full debug and so on?

Sebastian
