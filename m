Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEF2CA501
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391420AbgLAOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbgLAOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:07:34 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:06:48 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z14so1748305ilm.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8t4BBaX4dY2Q1whu27yoDRhLqFb2cf6H1DIa9itq5kA=;
        b=ptlcaT1RH6g5jo73/ATdEqyz2Y9+Gm0GzASKWVdnSTpRf6tAnQK94nfqffpbN4W1el
         BuGuxYIisagIndqLFQwNNmt4QDWQcC26ZnGnaKl38/Q8hzl6W1wW+ThQIoDCA5BNSeXM
         BmnTc7VrV3huP5tJeB81hnEWJhoVSaOTuB4cmpFeJBSMlC4Q9mqUryPdlifycuzInXoD
         TkCfZFngIElm1vLqtx12RStmK4oa/wcwvNe02afR1EadlxN8TBi8f4Pu0YXA8Swq6DO8
         c/J/t/fXf2jOSBdxzb1rs5l6sxEoI26kRzyxvmsDJYKTJGWZjjLuvXpTfbeW4Plz3wJz
         PbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8t4BBaX4dY2Q1whu27yoDRhLqFb2cf6H1DIa9itq5kA=;
        b=GP/j70okw5vWiK+QumhI2/y9TSqr9UrtZOZ1pCe7lDEc1gJBKgxKHD3JALsEIqyp3E
         /bT6MzmC+PYjRc7VSGCAqR1VaIonb3jFG5VVCa8lHJdx99Lx02NZ5ZheQyHbdWjGkvhp
         4G9LDe+oRlzZAYYy+/5lbgmleWjb8Py8A8sdtWAN6wt+1cK+OJbl4L09vopcLOqWmUc0
         jZrpQJFXJSWtNV9AJsHdW20B1t5NPM2YU+37uqkeTx7eeKnQu5X2EUX9Qr/Su4KniOSQ
         ghPYmjtyXRDzzlUsT+Vt7aM58eBWmgxROrBIvznn5SAaUyKk3kJh/603TXeQt/UksYF3
         ehdQ==
X-Gm-Message-State: AOAM530lCd1BVeiQjootxBFADLcSpZcc1NoJWO8Kh9tKJ3+KeWAUoSLS
        J7S7UhgD6Q5yYmAZ6tFPXf8ICF9qE2rWNGXOxPCTow3izZ61Xg==
X-Google-Smtp-Source: ABdhPJzHlf5Wc0szmBp2bVlJPrFl5E/OTCSlcuuILJgojr51/WzlEahvl3pVqmxNqHgcpqwuSxl894sjfERRgMsIzDw=
X-Received: by 2002:a92:680b:: with SMTP id d11mr2682917ilc.287.1606831608161;
 Tue, 01 Dec 2020 06:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20201130164704.22991-1-brgl@bgdev.pl> <20201130164704.22991-4-brgl@bgdev.pl>
 <20201201112656.GA32252@lst.de>
In-Reply-To: <20201201112656.GA32252@lst.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Dec 2020 15:06:37 +0100
Message-ID: <CAMRc=MfEtvPfeSCDb1Efgko7QpXFu7-4nuLvTfAoWBcuX_k5jw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] configfs: implement committable items
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:26 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 30, 2020 at 05:47:03PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This implements configfs committable items. We mostly follow the
> > documentation except that we extend config_group_ops with uncommit_item()
> > callback for reverting the changes made by commit_item().
> >
> > Each committable group has two sub-directories: pending and live. New
> > items can only be created in pending/. Attributes can only be modified
> > while the item is in pending/. Once it's ready to be committed, it must
> > be moved over to live/ using the rename() system call. This is when the
> > commit_item() function will be called.
> >
> > Implementation-wise: we reuse the default group mechanism to elegantly
> > plug the new pseude-groups into configfs. The pending group inherits the
> > parent group's operations so that config_items can be seamlesly created
> > in it using the callbacks supplied by the user as part of the committable
> > group itself.
>
> This looks pretty awkward in the hierachy, but I can't really think
> of anything else.  One idea would be to require fsync to stage updates,
> but that isn't really very well discoverable.

I'm not sure how that would work. fsync() a directory once the item is
configured to instantiate it?

I was thinking about different solutions other than the one already
defined but it always requires at least some kind of an additional
attribute (not defined by the user) to "commit" an item and in the end
rename() looks like a good candidate to me. We could possibly drop the
pending and live groups and simple use a magic suffix for committed
items e.g.: `mv myitem myitem_committed` but this would be even less
intuitive.

If this patch is extended with:

@@ -1103,6 +1103,8 @@ static void configfs_dump_one(struct
configfs_dirent *sd, int level)
  type_print(CONFIGFS_USET_DIR);
  type_print(CONFIGFS_USET_DEFAULT);
  type_print(CONFIGFS_USET_DROPPING);
+ type_print(CONFIGFS_GROUP_PENDING);
+ type_print(CONFIGFS_GROUP_LIVE);
 #undef type_print
 }

Then dumping the committable subsystem shows:

[  133.603035] configfs:    "04-committable-children":
[  133.603045] configfs:     CONFIGFS_DIR
[  133.603050] configfs:      "live":
[  133.603054] configfs:       CONFIGFS_DIR
[  133.603058] configfs:       CONFIGFS_USET_DIR
[  133.603062] configfs:       CONFIGFS_USET_DEFAULT
[  133.603066] configfs:       CONFIGFS_GROUP_LIVE
[  133.603070] configfs:        "dupa":
[  133.603074] configfs:         CONFIGFS_DIR
[  133.603078] configfs:          "committed":
[  133.603082] configfs:           CONFIGFS_ITEM_ATTR
[  133.603086] configfs:          "storeme":
[  133.603090] configfs:           CONFIGFS_ITEM_ATTR
[  133.603094] configfs:      "pending":
[  133.603160] configfs:       CONFIGFS_DIR
[  133.603167] configfs:       CONFIGFS_USET_DIR
[  133.603175] configfs:       CONFIGFS_USET_DEFAULT
[  133.603183] configfs:       CONFIGFS_GROUP_PENDING
[  133.603191] configfs:      "description":
[  133.603198] configfs:       CONFIGFS_ITEM_ATTR

Which doesn't look that bad IMO.

Bartosz
