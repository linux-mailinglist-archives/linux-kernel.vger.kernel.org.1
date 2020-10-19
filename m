Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A529310A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgJSWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729559AbgJSWSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:18:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F492223C;
        Mon, 19 Oct 2020 22:18:31 +0000 (UTC)
Date:   Mon, 19 Oct 2020 18:18:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] libtraceevent: install html files
Message-ID: <20201019181829.3e963a7f@gandalf.local.home>
In-Reply-To: <CADVatmMPHQvO1CwTEpgtotiDjAQiecbAQf=Mt_5oHHcqa2GV7w@mail.gmail.com>
References: <20201018211912.17541-1-sudipm.mukherjee@gmail.com>
        <20201019094234.0b36bb61@gandalf.local.home>
        <CADVatmMPHQvO1CwTEpgtotiDjAQiecbAQf=Mt_5oHHcqa2GV7w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 19:59:18 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> I was actually confused about which repo is to be followed for
> development purposes. I assumed all patches will land here and you
> will then mirror them to libtraceevent.git repo when you decide to
> make a release. I can send you a patch for libtraceevent.git repo if
> you want.

A release has already been made:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot/libtraceevent-1.1.0.tar.gz

-- Steve
