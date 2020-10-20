Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AE294411
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405227AbgJTUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbgJTUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:43:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5C422256;
        Tue, 20 Oct 2020 20:43:50 +0000 (UTC)
Date:   Tue, 20 Oct 2020 16:43:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/3 v2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
Message-ID: <20201020164348.4cf959ca@gandalf.local.home>
In-Reply-To: <8b122215-867a-2517-f754-fbe87118f00c@suse.cz>
References: <20200925211206.423598568@goodmis.org>
        <20200925211819.767526657@goodmis.org>
        <8b122215-867a-2517-f754-fbe87118f00c@suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 13:59:46 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> Nice! I'm late here, but you mentioned a v3, so FWIW:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

You are late ;-)

  afbe7973173a7ce0a68af8b33e44c967582297be

-- Steve
