Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805661F89AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFNQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFNQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 12:50:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A5C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 09:50:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so8111562lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNTbu2Bx7XRrmCnutxciM8zN4YdqKVJvKPFK7H3YQGg=;
        b=NF91Lq6jqiu3UTIblaZW89jQJu97X+NJpMZiCPOoS7jkyPk4uajF4J2cU/f9tEhBn0
         fLCM7fZMUTmXdz9Pj9yYR1TrHVa7OwMFD1XM6fElnwvlLWRFhMEeD0qDMqkKaOSjlDHG
         Wzdc/fHywJ5oUxwF36rm9fuK4Zpm6taSzZsb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNTbu2Bx7XRrmCnutxciM8zN4YdqKVJvKPFK7H3YQGg=;
        b=NGF3rU3g1PNoXLj7OXYsNNU4lfVRPjfH0lI4but1EcT7ftZT+098+fKhsnCHJreVTM
         /EEqRm9/C070SuP+KRZ7hSsnA1zFwAFWF4/mfXjU8umg5jZEs1rEvqzqwJmqk44U1THh
         ToDaTzfEQdrplSwhXK1X1n1IFVqh8XJ8G3f4I9Zb58VBpczq8GoYF+fliwrVmD+p8qcx
         1MGKFb63q63FmbL7LVIzrnJ7JUWfbRl2lrSEYuvWHJNE+RmKi4ZiQ9PYvpdIS4d5zCvO
         fJknrYFERMggA0sqMQgCohZ/5bCwcI+gLKc1vFHBljnRT9XJzT1TNQffMEbr0Odv1BIH
         KT+w==
X-Gm-Message-State: AOAM531yeFsj8sqcGCn4+GywOz0e671bsV6U1orwI07bzPc/NV/IopaQ
        xjnVEIrqvtdn6gWBzlUC3xxfD4vPllo=
X-Google-Smtp-Source: ABdhPJyIu2USXxeTQDmGJgfvXBcIZ89zZS/ggLsF+tKWjcSuJudfhkYGt1PGHDpKjVLAEkjGm8v/QQ==
X-Received: by 2002:a19:7612:: with SMTP id c18mr11710978lff.7.1592153434577;
        Sun, 14 Jun 2020 09:50:34 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id d8sm27652lfa.16.2020.06.14.09.50.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c17so16324949lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr10825078ljk.314.1592153433099;
 Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592135316.git.dsterba@suse.com>
In-Reply-To: <cover.1592135316.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 09:50:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
Message-ID: <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 4:56 AM David Sterba <dsterba@suse.com> wrote:
>
> Reverts are not great, but under current circumstances I don't see
> better options.

Pulled. Are people discussing how to make iomap work for everybody?
It's a bit sad if we can't have the major filesystems move away from
the old buffer head interfaces to a common more modern one..

             Linus
