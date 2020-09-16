Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3A26C138
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIPJ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:56:34 -0400
Received: from mail.monom.org ([188.138.9.77]:46082 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIPJ4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:56:33 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 943D9500509;
        Wed, 16 Sep 2020 11:56:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id E64D7500243;
        Wed, 16 Sep 2020 11:56:29 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.236-rt207
Date:   Wed, 16 Sep 2020 09:54:38 -0000
Message-ID: <160025007866.26918.17852793246324950029@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.236-rt207 stable release.

This is  an update to the latest stable Linux release. No RT spefic
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 54d0ac15510b6ff0c0d6f669a24dd82cf88f6918

Or to build 4.4.236-rt207 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.236.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.236-rt207.patch.xz

Enjoy!
Daniel
