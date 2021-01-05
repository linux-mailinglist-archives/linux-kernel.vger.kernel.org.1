Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1682EAE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbhAEP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727802AbhAEP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609860403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRNmBZOaPHwmEQZjlu49SykVwvAJ7tCQh5OPc44TFFA=;
        b=D96QoqrDR4Z6EYr5oLV7orh074S2JMQlT5FolCQGKuceM+fOaGNpW15sUE3shF+jIribVn
        HUo23hpYRqRxL2Mya/URpTUFG5HWpR7ylkNSG7cqwweueIF/uvJXg36aKYuQggH+hl9zEr
        /Ubhx+VZs6NmWyxVij7cO9m75lZhwf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-MgtMswYXNr6ZZdPA9ZMmRA-1; Tue, 05 Jan 2021 10:26:41 -0500
X-MC-Unique: MgtMswYXNr6ZZdPA9ZMmRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F887A0CA0;
        Tue,  5 Jan 2021 15:26:39 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A86105F9B8;
        Tue,  5 Jan 2021 15:26:38 +0000 (UTC)
Date:   Tue, 5 Jan 2021 09:26:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins:  fix gcc 11 indigestion with plugins...
Message-ID: <20210105152636.2kkiu3boooaimujd@treble>
References: <82487.1609006918@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82487.1609006918@turing-police>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 01:21:58PM -0500, Valdis Klētnieks wrote:
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> In fact, it works just fine with c++11, which has been in gcc since 4.8,
> and we now require 4.9 as a minimum.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

I'm also needing this.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

