Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF2255565
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgH1Hgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 03:36:54 -0400
Received: from mail.monom.org ([188.138.9.77]:53924 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1Hgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:36:53 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 0104050035A;
        Fri, 28 Aug 2020 09:36:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id AFF2250019C;
        Fri, 28 Aug 2020 09:36:50 +0200 (CEST)
Date:   Fri, 28 Aug 2020 09:36:50 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Daniel Vacek <neelx.g@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200828073650.kq4qaon2u4xsqqlr@beryllium.lan>
References: <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
 <20200827102840.msv556nrah4h4vmq@linutronix.de>
 <20200827112705.uleixtdmx3pacr5u@beryllium.lan>
 <20200827124611.tsivo4xopvoenfmy@beryllium.lan>
 <CAA7rmPG1j0vD4rtv2piLF1UV9qD4mfcXVAHfA3vqGniPUAerrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA7rmPG1j0vD4rtv2piLF1UV9qD4mfcXVAHfA3vqGniPUAerrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:50:24PM +0200, Daniel Vacek wrote:
> Maybe the threshold is 33554432, eg. 32 megs...

I've rearranged the load addresses for the kernel and the dtb and now
the board is booting again. Starting with a full test run now.

The size list was mainly to see if the v5.9 tree is showing abnormal
size regression. It doesn't look that's the case. All RT kernels are
bigger than the rest.
