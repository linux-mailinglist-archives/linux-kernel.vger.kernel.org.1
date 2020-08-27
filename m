Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD6254576
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgH0Mt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:49:59 -0400
Received: from mail.monom.org ([188.138.9.77]:50542 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgH0MqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:46:24 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 80B1150035A;
        Thu, 27 Aug 2020 14:46:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 3DC6F500103;
        Thu, 27 Aug 2020 14:46:12 +0200 (CEST)
Date:   Thu, 27 Aug 2020 14:46:11 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827124611.tsivo4xopvoenfmy@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
 <20200827102840.msv556nrah4h4vmq@linutronix.de>
 <20200827112705.uleixtdmx3pacr5u@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827112705.uleixtdmx3pacr5u@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would be interesting to see the size numbers for v5.6-rt? Hmm, I'll
> just start the compiler. It's all scripted anyway :)

v5.6-rt:

-rw-r--r-- 1 wagi users 28688896 Aug 27 13:38 rpi3-image-ll-v5.6.19-rt12
-rw-r--r-- 1 wagi users 28688896 Aug 27 13:34 rpi3-image-nohz-v5.6.19-rt12
-rw-r--r-- 1 wagi users 29669888 Aug 27 13:32 rpi3-image-none-v5.6.19-rt12
-rw-r--r-- 1 wagi users 33438208 Aug 27 13:30 rpi3-image-rt-v5.6.19-rt12
-rw-r--r-- 1 wagi users 28688896 Aug 27 13:38 rpi3-image-up-v5.6.19-rt12
-rw-r--r-- 1 wagi users 29669888 Aug 27 13:36 rpi3-image-vp-v5.6.19-rt12

v5.4-rt:

-rw-r--r-- 1 wagi users 27525632 Aug 27 14:40 rpi3-image-ll-v5.4.59-rt36
-rw-r--r-- 1 wagi users 27525632 Aug 27 14:36 rpi3-image-nohz-v5.4.59-rt36
-rw-r--r-- 1 wagi users 28506624 Aug 27 14:34 rpi3-image-none-v5.4.59-rt36
-rw-r--r-- 1 wagi users 32360960 Aug 27 14:32 rpi3-image-rt-v5.4.59-rt36
-rw-r--r-- 1 wagi users 27525632 Aug 27 14:40 rpi3-image-up-v5.4.59-rt36
-rw-r--r-- 1 wagi users 28506624 Aug 27 14:38 rpi3-image-vp-v5.4.59-rt36

So in previous releases the size offset was roughly around 4MB.
