Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00A11A48E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgDJR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:26:10 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F258820801;
        Fri, 10 Apr 2020 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539570;
        bh=BmcySnDEYGRj7rC1MSQD497Gs7G319rAZivMgHsxh60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mD2OKIQ6zIch+bCUwBx4o/3x8StzS9Uvd9RHV2xSIvqDwzUO45SaeSFN6xIm2Hqr4
         KXR9XWD/Gl4paRTiy7VjgeDpoAzRfgRl9H8By9Sgf/iWMy0pYwmWxZinheOB12z98h
         F5NM8jP79+A6kU2nv4Gsh9S19xDxoXEGAA9aDcCs=
Date:   Fri, 10 Apr 2020 10:26:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-Id: <20200410102609.245f93639ece2667c3f70e5c@linux-foundation.org>
In-Reply-To: <22DAFAC7-9F39-4042-BC79-B27963A13E3D@lca.pw>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
        <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
        <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
        <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
        <76e8bbed-21d1-22e1-4148-5a5766652c0d@I-love.SAKURA.ne.jp>
        <22DAFAC7-9F39-4042-BC79-B27963A13E3D@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 10:26:23 -0400 Qian Cai <cai@lca.pw> wrote:

> I don't set panic_on_warn. I'll deal with warnings afterwards.

I'm not understanding why sysbot sets panic_on_warn.  This decision
will needlessly turn many kernel errors into wont-boot situations and
will block further testing?
