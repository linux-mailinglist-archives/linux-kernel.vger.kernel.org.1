Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6833926EA01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRAkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:40:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61714C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:40:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b2so3568006qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiWtLtDGF+mbpQMLR50cNaArfWqLA5zM1FNbb2BWLtE=;
        b=JNQ3qdoWnpY2C+vL+PxiQUinE5r83Ya4m4M9y1NGodZPRYXFzOjbpzB9NPd+kEcGI2
         pfGErV51tWsTSE1huFj/By8DJXgOSdEysjt0DbLmAwZ6H92LadeTEKzpYZMNWm2DK+6v
         9CA1Q2XJsuOw7FJWEs9rJSvwFwHK+edgjHkTWC6CSbYbIvz88RxCnlVBHKY5cyoExOAA
         XUNijeZawtjMU9tAzbOSMTQ10uSQwMBgoFrcXMNxnT/+VWHgOzNh4tQ+Zl8BgvxSQw9o
         YW7SRSXimhdwUZA8rI8h6l/e9K5jCmOOk3Z9a8j5BdhdLmYOrGN0I7ZXOX3D2NwEoXNr
         nNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiWtLtDGF+mbpQMLR50cNaArfWqLA5zM1FNbb2BWLtE=;
        b=n5MSZA+xBzDdc8eM9DVGHsHQ5uKnUeubNXoWNr9T4ekPdHk+1oYK0Y5TxppT1OLtbc
         q2hBFwwnIwGLPlqe8b2e2qHdrar3y38nCTyPikJ90S4meS8ai0C+1nmWvOTwbaqTN3om
         1+M87QESrzxPwN+L4AYknJ+d7fi4nVLFsJBRpEI568y2IGIRYXqBoWsnltctoWjbVTca
         iOc69anUh0KIDiX+4aP/YlZczaqcWzjOT6kPM2v5WPh7ywdo24NTlHOjlxF3XcBxzXlV
         QeoF5/ymbRv791YdvBdBXyyP3rzhVM8kRRmwHChMG6sUi0dknvyN9VAJI36k7jDbTwh1
         7/Ag==
X-Gm-Message-State: AOAM5307iKprt2Qvgkt2rlKkCE75VFA8wRKpFHd1PM7kwCE0A7v1pCOp
        ++LKqjpoIR0Fj9Anb4qTFYbuSTNNURnz2QeW7Gemfort5A4=
X-Google-Smtp-Source: ABdhPJy6gwtDjN36l3NZwcD7QINChiEPoPq6nuSfu49TfysXqTl5qCy+1ybS08pYcX5KHunOrFdeSWOZifN+DttJlaI=
X-Received: by 2002:ac8:660a:: with SMTP id c10mr18652652qtp.300.1600389617338;
 Thu, 17 Sep 2020 17:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200917234953.CB1D295C0A69@us180.sjc.aristanetworks.com> <20200917170203.1a363082@hermes.lan>
In-Reply-To: <20200917170203.1a363082@hermes.lan>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 17 Sep 2020 17:40:06 -0700
Message-ID: <CA+HUmGhEVFaC1gGJiXK7N0hfiDf-4x3of3f54n2cbiDz+SnVZQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: use exponential backoff in netdev_wait_allrefs
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 5:02 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Is there anyway to make RCU trigger faster?

This is a case of the networking code requiring multiple cascading grace periods
(functions executing at the end of a period scheduling more functions
for the end
of the next period), so it's a matter of how many steps are required,
rather than
how fast each step is, if that is what you are suggesting. I don't
think that expediting
rcu periods would help in this case, but I will defer to people with better
knowledge of the networking code than me to comment.
