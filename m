Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B31F4137
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgFIQmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Jun 2020 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgFIQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:42:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45065C05BD1E;
        Tue,  9 Jun 2020 09:42:17 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jihKH-0004wK-OB; Tue, 09 Jun 2020 18:42:13 +0200
Date:   Tue, 9 Jun 2020 18:42:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
Message-ID: <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org>
 <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
 <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
 <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
 <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
 <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
 <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
 <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
 <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09 19:40:03 [+0300], Ramon Fried wrote:
> Correction. normal kernel is running with RT enabled, crash kernel without. 

no RT and no SMP in your crash kernel? So this information in your first
email would have saved me some time…

Sebastian
