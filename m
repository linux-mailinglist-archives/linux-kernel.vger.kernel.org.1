Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7142128D70D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbgJMXfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:35:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389019AbgJMXfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:35:41 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602632139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vvC8W5yBU9l0zaxuKf8yQnJWKFUBj01DdJSY9iC2fHQ=;
        b=OiFGFpbv2r3AMouySLJdd7W2ivcvP0b4vuhzXec4WS63BJDjLXkjvSYDBHsAQqzbSl1snt
        by6z3l24YRRkCyP3wWwC4szKYrlJHH17KdZLiG14CsPGA+t7witcggpjAs3OE7IeOUwmTE
        jAUboNsjRbR9HcQ2MHBTMtAe6KKZPdTVmQAxWInV0fnx1Tb96kNWl97F1jMHj5RIFrYaru
        t6xeC+5yB4ufFiX3rXWuQJ+0ybi2EmsXAxZaLpx1Jy7sXJvAocr/8TeBvw75Yi02SK4sxG
        e2XrrpDbmxaMYwyxV7CJe7x78D7ErvwU0CYIKkTqwOyetZnlfSHzDaxmRENOJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602632139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vvC8W5yBU9l0zaxuKf8yQnJWKFUBj01DdJSY9iC2fHQ=;
        b=t8WuCp/yDfTPDDYIEtT4WP69AewIm3ygfBz9Ut2udVMNyq1FsmlOhWIuTAd01qaNIzqf6E
        v0+kyOwUmFDrxKCQ==
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] tracehook: clear TIF_NOTIFY_RESUME in tracehook_notify_resume()
In-Reply-To: <20201008152752.218889-2-axboe@kernel.dk>
Date:   Wed, 14 Oct 2020 01:35:39 +0200
Message-ID: <87eem1d7hw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08 2020 at 09:27, Jens Axboe wrote:
> All the callers currently do this, clean it up and move the clearing
> into tracehook_notify_resume() instead.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Nice cleanup!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
