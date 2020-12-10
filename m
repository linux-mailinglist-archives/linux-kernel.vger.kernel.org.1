Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3C2D4FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgLJAmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgLJAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:42:07 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C4C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:41:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r24so5714057lfm.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrFHmG50c/nNql7cN9PvwrwjyMGC5Bwc4vaN3xil6d8=;
        b=B1O7JYmsBuTSQSY2dW1rHauJ0h7aheOWuUIpdRFOdc/VF7y94d9X0/Rzh6p0VoW9pH
         UxXWjLXwEHSHMpFeAe+P0rZpkVXZXearYow4CnNblmwWpTnvSs3AKX957YfWvXxNFqAj
         1DP20i8Z4w2vPawIGvRPq/yy0Jhvkb3T7RVKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrFHmG50c/nNql7cN9PvwrwjyMGC5Bwc4vaN3xil6d8=;
        b=S9UVd09ySH9d6m/nzbGWrFl9KX9WLbN6wKTvzAMCSYfak+g49Ew338Yuo+GDrKu88w
         WwDzAIlPAvJGIX8Zg2a9Ca9J7xoOsGTwHtcX6SZZLaIhUY6LorN2nraTUKgUblDJIKE2
         jRhpThD95CdeEHtIq7eV1I8rlqTOaPW12w4Ac0zjRKGmhtAJtawK3EtdQxCXWCXyF0g8
         aUymOAa5wFWWkJuQ5sYArMa1DqFlAgzYWv243Tx8S6aiyTyrgAmxIwuMNrPuzSzMo9Qf
         sm9oYIC0I2Ene5oQvpv+x8/xjaoC2hZJZ0EMd4L0C/LYO08oqQxdSX3lbi6KgUzoNZ3K
         RokA==
X-Gm-Message-State: AOAM531rc9Z6ruyHnUUYGJfGfywo/0gPFPYTJrJzrGVDK7ppf70uVP9V
        hZHRhcbWrrB13Aw3MubVYMiygLQfCogG+w==
X-Google-Smtp-Source: ABdhPJyhblQWi+3F30DGS+CI/FC9URUG7JEoFgr4X8Ts1tFiCctciVHxitPXIXa9cipahge9S9Gqzw==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr47184lfg.381.1607560885006;
        Wed, 09 Dec 2020 16:41:25 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u27sm326413lfk.47.2020.12.09.16.41.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 16:41:23 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m19so5759163lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:41:23 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr1659716lfd.201.1607560883025;
 Wed, 09 Dec 2020 16:41:23 -0800 (PST)
MIME-Version: 1.0
References: <877dprvs8e.fsf@x220.int.ebiederm.org> <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org> <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org> <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk> <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
 <20201209230755.GV7338@casper.infradead.org> <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
 <20201210003922.GL2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201210003922.GL2657@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 16:41:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
Message-ID: <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 4:39 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Like this, then?

Ack.

           Linus
