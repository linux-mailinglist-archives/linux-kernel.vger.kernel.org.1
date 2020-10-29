Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3B29F215
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgJ2Qsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbgJ2QsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603990081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwZQ2oN6WxzK0UUncdaVDf1saKXhHV2p2lzyo7kKTGg=;
        b=D0TFV20SMf+eCOlXjdnnASI0eVTPpeHSXbq/mFjN82ui1HVC3YVsuW8IGzCZqUa+iy/hAp
        2mXu5q8Ti0QgyHweL40kQU3aiifNBeiMlMLWlE2RLeKi90W88YwjEiTcZHuarUVS5WJnSP
        UyjXxZK4RsrgB3wJ2Rk7XIBGlhdVAb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-ARyo9KBvOw-DHqiZaF1ENw-1; Thu, 29 Oct 2020 12:47:57 -0400
X-MC-Unique: ARyo9KBvOw-DHqiZaF1ENw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 451A6807321;
        Thu, 29 Oct 2020 16:47:56 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B96B56EF68;
        Thu, 29 Oct 2020 16:47:55 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
References: <20201019102654.16642-1-gscrivan@redhat.com>
        <20201029153859.numo2fc42vgf3ppk@wittgenstein>
Date:   Thu, 29 Oct 2020 17:47:53 +0100
In-Reply-To: <20201029153859.numo2fc42vgf3ppk@wittgenstein> (Christian
        Brauner's message of "Thu, 29 Oct 2020 16:38:59 +0100")
Message-ID: <87mu05vv0m.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Oct 19, 2020 at 12:26:52PM +0200, Giuseppe Scrivano wrote:
>> When the new flag is used, close_range will set the close-on-exec bit
>> for the file descriptors instead of close()-ing them.
>> 
>> It is useful for e.g. container runtimes that want to minimize the
>> number of syscalls used after a seccomp profile is installed but want
>> to keep some fds open until the container process is executed.
>> 
>> v1->v2:
>> * move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
>> * use bitmap_set() to set the close-on-exec bits in the bitmap.
>> * add test with rlimit(RLIMIT_NOFILE) in place.
>> * use "cur_max" that is already used by close_range(..., 0).
>
> I'm picking this up for some testing, thanks
> Christian

thanks!  I've addressed the comments you had for v2 and pushed them
here[1] but I've not sent yet v3 as I was waiting for a feedback from Al
whether using bitmap_set() is fine.

Regards,
Giuseppe

[1] https://github.com/giuseppe/linux/tree/close-range-cloexec

