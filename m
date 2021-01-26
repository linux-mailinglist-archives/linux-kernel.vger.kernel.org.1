Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63654304F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhA0DOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389976AbhAZTY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:24:29 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611689017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvHTS6sqJ7HqI7izCJmQil44D253ycSG/sA3ciy1468=;
        b=mZ5oT3mkLiLm249j6uSpRoyjv7A6aCCbmicd1EXM7eJCfb1MrWwpdhzHK5X2mmAcIe5Ni6
        tG+3zdNHUz69yWMLSV1nwZKcGJacx2l2be1+NcRvJRQOj5U1P/6B8p/9fm+BEzJTKBJaLO
        ug3IGH1POymIWiN9Pf8JpWlvFUP90KweKmLLDij0TwfOx7kbk8xMWGCplzXrnwitTSShMP
        F9t6zr/+Z05nednY9ZBtugDVLsL4SRRuj3Ufd3C7T0YUQ02oM+u8CCPz8gDKv8kP2jNnRp
        PjHaK3S03Prq9bQ1QqkKb6ZStB6HOlv6lMP5rQMpOZiCyroa4OKYDSmzzBuH1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611689017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvHTS6sqJ7HqI7izCJmQil44D253ycSG/sA3ciy1468=;
        b=8H6hHy0D7neM6mntl2DnKFu4ZodjkFfunTgbDYdMqJ/CzZj+vxmIKJ9YT/sFde5LUPcLDj
        ijxLYx4IdeHswJAg==
To:     Steven Rostedt <rostedt@goodmis.org>, Timur Tabi <timur@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
In-Reply-To: <20210126124032.0915f408@gandalf.local.home>
References: <20210116220950.47078-1-timur@kernel.org> <20210118182635.GD2260413@casper.infradead.org> <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org> <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain> <20210119014725.GH2260413@casper.infradead.org> <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain> <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz> <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org> <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz> <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org> <20210126123912.23a5c3a1@gandalf.local.home> <20210126124032.0915f408@gandalf.local.home>
Date:   Tue, 26 Jan 2021 20:29:36 +0106
Message-ID: <87mtwv8ptz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26, Steven Rostedt <rostedt@goodmis.org> wrote:
> And even if we make this a boot time option, perhaps we should still
> include that nasty dmesg notice, which will let people know that the
> kernel has unhashed values.

+1

The notice would probably be the main motivation for distros/users to
avoid unhashed values unless truly debugging. Which is what we want.

John Ogness
