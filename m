Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291028AFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgJLIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:09:14 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43326 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgJLIJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:09:14 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09C89Bfo011412;
        Mon, 12 Oct 2020 10:09:11 +0200
Date:   Mon, 12 Oct 2020 10:09:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Samuel Hernandez <sam.hernandez.amador@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture/nolibc: Fix a typo in header file
Message-ID: <20201012080911.GC11282@1wt.eu>
References: <20201011182230.25602-1-sam.hernandez.amador@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011182230.25602-1-sam.hernandez.amador@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Samuel,

On Sun, Oct 11, 2020 at 02:22:31PM -0400, Samuel Hernandez wrote:
> Signed-off-by: Samuel Hernandez <sam.hernandez.amador@gmail.com>
> ---
> This fixes a supposed typo. Before this, the AT_FDCWD macro would be defined
> regardless of whether or not it's been defined before.

Good catch!

Please note that the commit message must be placed *before* the "---"
and before the signed-off-by. No need to resend, I'll adjust it on my
end.

Thank you,
Willy
