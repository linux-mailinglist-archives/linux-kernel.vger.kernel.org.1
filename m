Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2882204F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGOG3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 02:29:06 -0400
Received: from mail.monom.org ([188.138.9.77]:53442 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgGOG3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:29:05 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 7C22250052B;
        Wed, 15 Jul 2020 08:29:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 0B49B50042A;
        Wed, 15 Jul 2020 08:29:03 +0200 (CEST)
Date:   Wed, 15 Jul 2020 08:29:02 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
Message-ID: <20200715062902.zaskq5itkqa2wvxr@beryllium.lan>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
 <20200714183512.GA18816@duo.ucw.cz>
 <20200714154352.04794760@oasis.local.home>
 <0faffeb615b74212f65b813ffde0b096fa7451be.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faffeb615b74212f65b813ffde0b096fa7451be.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:48:09PM -0500, Tom Zanussi wrote:
> Yeah, so do I, it's just that the srt script doesn't push the
> intervening tags (but does push the release tags).

It's on the TOOD list to add this feature to srt for ages... sorry haven't
found the time yet
