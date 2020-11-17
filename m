Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B52B69E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgKQQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKQQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:19:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62716C0613CF;
        Tue, 17 Nov 2020 08:19:42 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so20923920qkf.3;
        Tue, 17 Nov 2020 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0bP0N5G3q4990O7UPG9qRselKLApk1bnmbnwIqPu2sM=;
        b=quCQWsqM/G7NUW8nG/cRtbhFeRATbrfM9fvJTlEYihkQrZEOLYtBP0T5+AdNrmyCSk
         Ds9CtnwjcEjJeU2bGSCgXIowOWbO1KxckhDVCCfD9uhxcFcI0UFdc/6QEuc9iqFBSFSn
         Zmn1RHMubmXzoY5sR8r5Ge9hBIk9e5DQaDICCibObS3rDRDWeBjCfZhGbNWXfKlHPrc2
         BUSBWsxSdbwNSN0r7r/tSKHNL7fiwuNnZuxNhO6fNYFWCFUmc2EJ9vmdbEzCsQYruclj
         dynVQvYLjIx2dY9EegBovc3Xw/x3onkQC6A5TDyjY+NnGZwzm92vv5LDgFfLe9emkO6O
         IsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bP0N5G3q4990O7UPG9qRselKLApk1bnmbnwIqPu2sM=;
        b=PAuuM/3QzcQzYUK8nLlOnK3/+1uPQ89BLAt5aUq0ys7Wwz8TiYxRoQ7DxQt3DgQjcj
         X3wF2r4XNHlqc3uO/QwXgHb0xkCobzJCktX6QS+aGxaqYlaMhalU2tBvNST7gtygLZL8
         GViEoIg46crj3pgk2txUMnk9xWfIPBAELDRTVGXRa7qN0uqw776p7LQyoAKtCCWlikMb
         oGs/gQ/wzt75I0V9xNRLpDrz45npPLW6yif/Qdnr0j3/9AOpArmN58kGuEuzRHkCJX+N
         Sc0zuyQaHIWjhuHFXu+5YZ0usIuo5WX4Q8nA4h489NnUveau4Pm2+hHeTocS10VV8LTj
         rmEw==
X-Gm-Message-State: AOAM532hFzjvjG6DYi5YaYvVvxDxBHOrgp0G2fP5jjf62LHtY2Aw4/BG
        sZkuuEzCQz1S2vNy9efvltM=
X-Google-Smtp-Source: ABdhPJzufKely6Ve/NrxH3TgVvKFp2euIaxPShtuwEADEG9FSgYwKaPVuHGMV+IJYsywA6Hamm8K6w==
X-Received: by 2002:a37:4948:: with SMTP id w69mr299290qka.472.1605629981408;
        Tue, 17 Nov 2020 08:19:41 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id b64sm2779946qkg.19.2020.11.17.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:19:40 -0800 (PST)
Date:   Tue, 17 Nov 2020 09:19:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: remove obsolete rb_event_is_commit()
Message-ID: <20201117161938.GA1271942@ubuntu-m3-large-x86>
References: <20201117053703.11275-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117053703.11275-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:37:03AM +0100, Lukas Bulwahn wrote:
> Commit a389d86f7fd0 ("ring-buffer: Have nested events still record running
> time stamp") removed the only uses of rb_event_is_commit() in
> rb_update_event() and rb_update_write_stamp().
> 
> Hence, since then, make CC=clang W=1 warns:
> 
>   kernel/trace/ring_buffer.c:2763:1:
>     warning: unused function 'rb_event_is_commit' [-Wunused-function]
> 
> Remove this obsolete function.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
