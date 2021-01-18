Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAE2FA81A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436820AbhARR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436799AbhARR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610992525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vm9rIUiGAkv8j7m5tGjVI7arm5LRraDLYgpQsMq2H+k=;
        b=LDun2ujOmuBHT1UE7T0TpSNWFznC99/Ly6hyhiZERZDuDiCOeQ66dw/01M6UOWuQDMTAMr
        tEW2wTJ8mIO8I20pW7gbwyRLoRD8Ovf2DSS+6dgqBcn8Y4zJv9Y85C+puVNLUCO+LkH2S6
        hnIC+I7FE8HfqsHZfaKr4/GiMQFQOUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24--UUlcuZ6NJmiB_Ji_P4jnA-1; Mon, 18 Jan 2021 12:55:22 -0500
X-MC-Unique: -UUlcuZ6NJmiB_Ji_P4jnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240F4107ACE3;
        Mon, 18 Jan 2021 17:55:21 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20A9027CB4;
        Mon, 18 Jan 2021 17:55:18 +0000 (UTC)
Date:   Mon, 18 Jan 2021 11:55:12 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jan 18 (objtool: 2 warnings)
Message-ID: <20210118175512.jffm2pjarsbavtqb@treble>
References: <20210118174853.4be516ca@canb.auug.org.au>
 <4e0c0222-c413-8389-ba8b-572041f81eb0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e0c0222-c413-8389-ba8b-572041f81eb0@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:16:14AM -0800, Randy Dunlap wrote:
> On 1/17/21 10:48 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20210115:
> > 
> 
> on x86_64:
> 
> lib/iov_iter.o: warning: objtool: iovec_from_user()+0x157: call to __ubsan_handle_add_overflow() with UACCESS enabled
> fs/select.o: warning: objtool: do_sys_poll()+0x669: call to __ubsan_handle_sub_overflow() with UACCESS enabled

Under discussion:

  https://lkml.kernel.org/r/590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com

-- 
Josh

