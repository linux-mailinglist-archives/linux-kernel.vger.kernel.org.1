Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3D21ADA1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 05:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGJDpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 23:45:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:38338 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgGJDpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:45:35 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 06A3jNoZ024988;
        Fri, 10 Jul 2020 05:45:23 +0200
Date:   Fri, 10 Jul 2020 05:45:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <20200710034523.GA24981@1wt.eu>
References: <202007091110.205DC6A9@keescook>
 <20200709204255.GA29288@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709204255.GA29288@willie-the-truck>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:42:56PM +0100, Will Deacon wrote:
> Acked-by: Will Deacon <will@kernel.org>
> 
> Hopefully "plain text" implies unencrypted as much as it does "not html".

I would have liked "(i.e. not html)" to be added after "plain text", but
I figured that those who do that often don't even know what this means
so that will probably not help them avoid their messages being stored
into a spambox :-/

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
