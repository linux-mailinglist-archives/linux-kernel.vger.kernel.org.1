Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D248A2DF393
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 05:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLTEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 23:48:46 -0500
Received: from mail.efficios.com ([167.114.26.124]:47556 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgLTEsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 23:48:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C7E622E839A;
        Sat, 19 Dec 2020 23:48:04 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pw1zU6eRf8YH; Sat, 19 Dec 2020 23:48:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 675252E82A4;
        Sat, 19 Dec 2020 23:48:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 675252E82A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1608439684;
        bh=Lk9DAUYi457LuXbQYMHGuDJkzWjmmcJLZglkXK6gdHw=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=c6qMSWj/rXRgc+w9P5B9j/pUvKf1WrVNVIYvgpXZs81z3aETr/hxYWMc79qxO/JSd
         TkWX9JDN3jtfIF8pXEGRwDoq9zUcjSekmTK7Z4lOcduLbKDJozDIInq/oH6kZGSk9g
         RuGudvFqshw5ZSAW0ZfT5AjkEpduEjbpKrHOMFIHKdNTY8lUWvLh9HoCAafwP4XWdN
         DQsVGpYflypPBFd2ZMRRVfG1kOT53tfH6al8GfuOkDsOtYJtuJIvr84o2mZ7nni4tu
         XU+Exo3qztVl+/sR3MQWF/b6keZ9K1edV1J9fISQNim8ai7w7tAnPect5u8NwSIDXz
         KjvGOLnKbzryQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HqLyW-hjsYlV; Sat, 19 Dec 2020 23:48:04 -0500 (EST)
Received: from [10.0.0.213] (192-222-157-6.qc.cable.ebox.net [192.222.157.6])
        by mail.efficios.com (Postfix) with ESMTPSA id 315AE2E82A3;
        Sat, 19 Dec 2020 23:48:04 -0500 (EST)
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its
 pid unexpectedly
To:     Oleg Nesterov <oleg@redhat.com>, Pedro Alves <palves@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20201217142931.GA8865@redhat.com>
 <875z50roia.fsf@x220.int.ebiederm.org>
 <fc796624-2660-8c2b-0956-2c9ba8281952@redhat.com>
 <20201219193313.GB9539@redhat.com>
From:   Simon Marchi <simon.marchi@efficios.com>
Message-ID: <e8644e25-042f-6c52-533a-da097fc566e9@efficios.com>
Date:   Sat, 19 Dec 2020 23:48:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201219193313.GB9539@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-19 2:33 p.m., Oleg Nesterov wrote:
> OOPS! Sorry Simon, yes I forgot to add reported-by. Andrew, or Eric, if
> you take this patch, could you also add
> 
> 	Reported-by: Simon Marchi <simon.marchi@efficios.com>

I tried the original reproducer on a patched kernel, and it looks good.
GDB's behavior is still not super clean when this situation happens: a
PTRACE_GETREGS on the (disappeared) leader now fails with ESRCH (that's
what we want), and that interrupts the "continue" command and
unexpectedly brings back the prompt while leaving the other thread
running.  But that is all logic that will have to be fixed inside GDB.

So, feel free to add

  Acked-by: Simon Marchi <simon.marchi@efficios.com>

too.

Thanks!

Simon
