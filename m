Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB62F6B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbhANTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbhANTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPOXsts+93soL5zoX+FJXGHPlknaFZbtSi1SOaZES2E=;
        b=g3mcgLA05qPJ8aVwIb1JtZKUtpojH8S8zwsdxAq/PAC4pQiRdWqboLkRyDln/FalsfL+8v
        NLXhMYenJGgJFxvoYF1xj0sL3Ff0ddZtsGk8VLCvgXATiM/vC9P7uAb7n0BSaMf0zBnSRb
        27HQ/FX1p0ZueqCbLkk/Ffe8kdtATrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ZfqoNEQeNTirgDyUJZZXrg-1; Thu, 14 Jan 2021 14:47:57 -0500
X-MC-Unique: ZfqoNEQeNTirgDyUJZZXrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D0A806661;
        Thu, 14 Jan 2021 19:47:56 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC54960C6A;
        Thu, 14 Jan 2021 19:47:55 +0000 (UTC)
Date:   Thu, 14 Jan 2021 13:47:53 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Hack, Vanessa" <vanessa.hack@fau.de>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: objtool/ORC generation for noreturn functions
Message-ID: <20210114194753.ktjvddnt6g3yopl2@treble>
References: <daf04159-a458-4f0d-9f29-d8ef5a63fae6@email.android.com>
 <20210113184131.yh4zh4olfkdpydv7@treble>
 <126f2c2ccadebcba37864453135d95d7@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <126f2c2ccadebcba37864453135d95d7@fau.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:35:38PM +0100, Hack, Vanessa wrote:
> Substracting 1 from the instruction pointer made it work :-) Thank you
> again! The unwinder now seems to figure out reliable and unreliable stack
> addresses for 'standard' call chains that only consist of regular calls.

Good!  I'm glad it was an easy fix.

> > Also, please let me know when the paper is available to read :-)
> 
> Of course, I will send you a link when the thesis is finished.

Looking forward to it!

-- 
Josh

