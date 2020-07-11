Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA821C575
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 19:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgGKROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 13:14:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGKROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:14:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C1FADBA71;
        Sat, 11 Jul 2020 13:13:59 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=hvv4yGX9p7fbVfRfcjSHbd4wTg0=; b=wzoZdz
        hquq98qv3JmRfW52IsHxj5DNyMeUO0cF7NjeDBFTCFRhce0MFfDippKZ7ORAfEb1
        3YXPXrrd5B5GWkC9KWBomJ/zNDv6CFq39cbs2HDuolxiDQOHt7ckiNffCLYjgIsg
        +MeBh5hg5NI5LGTcUGlMoGZWkWbxp2OWaWR/o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24BACDBA70;
        Sat, 11 Jul 2020 13:13:59 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=ldpreload.com;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=mesmtp; bh=YlipbSjz8/cmz3AyHS0eTbZ5XkkKCJDg/NrgpldKAPk=; b=oh97ADewY5hSUoLUX7UCBBjvUtsFzBi/GiMJ4iSHkEZlCjV85cOWPGxB21OmYNdZfPbu3SAgCOrmP1IruwQqkVVlUWotSdwhSKAlto014b6hypOSONwoE+QJTc5EPTM3Z2hHun4Wx0D/kz2da+/6cn8y9gWU8IpAr53LfaBSCww=
Received: from cactuar.ldpreload.com (unknown [198.27.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E869DDBA12;
        Sat, 11 Jul 2020 13:13:55 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
Date:   Sat, 11 Jul 2020 13:13:54 -0400 (EDT)
From:   Geoffrey Thomas <geofft@ldpreload.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     alex.gaynor@gmail.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.2007111307100.4589@titan.ldpreload.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Pobox-Relay-ID: E6E95AD6-C399-11EA-9281-843F439F7C89-67873895!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020, Nick Desaulniers wrote:

> Hello folks,
> I'm working on putting together an LLVM "Micro Conference" for the
> upcoming Linux Plumbers Conf
> (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> solidified yet, but I would really like to run a session on support
> for Rust "in tree."  I suspect we could cover technical aspects of
> what that might look like (I have a prototype of that, was trivial to
> wire up KBuild support), but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"
>
> Question to folks explicitly in To:, are you planning on attending plumbers?
>
> If so, would this be an interesting topic that you'd participate in?

Like Alex - I hadn't decided yet but I'll definitely attend for this!

-- 
Geoffrey Thomas
https://ldpreload.com
geofft@ldpreload.com


