Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3592FD9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436474AbhATTcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392218AbhATT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:28:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:27:45 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h7so6431580lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmalMaWpEkSWH/aW9GjTN8dg2GRrod3zaQ74soBT6OU=;
        b=BKArcCnaPXIY8j1QgRxvBFX/gBQn0dsm5rQUs6MCoaWbZUdHIeCUOCY93EJd9+A4T8
         ZrMR4JSa+Et46SLZ9m+BUCAE6HkCsvFn+VrvAldXm1eCzLr0gff53Bv7yeXRXr4KTqXL
         vv3Ypk2sdiucIQrQjQJo+GlF1N9g3Yicv8DyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmalMaWpEkSWH/aW9GjTN8dg2GRrod3zaQ74soBT6OU=;
        b=bvhWyJmpqbsFf2qAyJAKbDiEz7T7oCZ6vosScqqqOnh8KB1zEd9RGjYbax8A0V+C1v
         CRLs4F13KGmuqAhizz6UhUPSr7uHE0hBxhOG6lKG/uN1a+TGk+sNgs0XLBajtwNjWpSG
         2GSxT6xpt/Y40E6o5YTqIenmr5bOp9LmTJWBpzdWSSH4cKldkk60qhm+fnJ5CKoz92AH
         mrXkJU7fQnw6Q81hnHtk2zgaSdpp3FMyEk0RzhDdtXb/Z22/eol6P5/eoTeqc1HYsUVR
         Meqqzfvj6qx9VI/Eb5Kvzh99e8QvDvrLzRsEYXpQc5Hzh4zbeZet4ydg+zaCh2YjyDuz
         SmuA==
X-Gm-Message-State: AOAM530SL8GCcfw6KZMRyE2bW7MfzBLnHtA+w3uQmLohYArA9or9OoLm
        JgX0nYWDm9JAq/qA7bVd4Ni4Nzpbr2aAEQ==
X-Google-Smtp-Source: ABdhPJwtF8xu4JsZzSoZh2exULwgAHJb9vBK90TshArIvqT69oR+c7WNjLyxjjFcrrgYWfWIfEFzJg==
X-Received: by 2002:a19:770c:: with SMTP id s12mr4711869lfc.367.1611170863902;
        Wed, 20 Jan 2021 11:27:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z8sm197544ljk.88.2021.01.20.11.27.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:27:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x23so27378203lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:27:42 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr4969951ljy.61.1611170862293;
 Wed, 20 Jan 2021 11:27:42 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca> <20210120191116.GC740243@zeniv-ca>
In-Reply-To: <20210120191116.GC740243@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 11:27:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
Message-ID: <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Why do we care about O_APPEND on anything without FMODE_PWRITE (including
> pipes), anyway?  All writes there ignore position, after all...

We shouldn't care.

Also, I think we should try to move away from FMODE_PWRITE/PREAD
entirely, and use FMODE_STREAM as the primary "this thing doesn't have
a position at all".

That's what gets rid of all the f_pos locking etc after all. The
FMODE_PWRITE/PREAD flags are I think legacy (although we do seem to
have the seq_file case that normally allows position on reads, but not
on writes, so we may need to keep all three bits).

Anyway, I think that with FMODE_STREAM, O_APPEND definitely should be a no-op.

            Linus
