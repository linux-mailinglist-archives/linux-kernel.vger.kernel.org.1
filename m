Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DC30491A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbhAZF36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:58 -0500
Received: from verein.lst.de ([213.95.11.211]:43924 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbhAYKR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:17:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22A9B68B05; Mon, 25 Jan 2021 11:16:25 +0100 (CET)
Date:   Mon, 25 Jan 2021 11:16:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fs/pipe: allow sendfile() to pipe again
Message-ID: <20210125101625.GA13672@lst.de>
References: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com> <20210125101615.efceefcaeae0.Ibe2d56dfaa49d7a366c835b5ae0f0a5c2d643ede@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125101615.efceefcaeae0.Ibe2d56dfaa49d7a366c835b5ae0f0a5c2d643ede@changeid>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
