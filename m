Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0F27D31D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgI2PuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2PuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:50:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:50:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so4454718ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=n2YecrhMymln3awuXJw++CHN4dPWLrsnfS2HnN0/bEM=;
        b=sGxmBjgh91GVzgXXRkq1XzI0BQ5vZCfapygu2r9H1uVIhMYKqahWdsHbCsbWcABRE9
         r2hB6kXWQOLmB3u7owxA9g8auyyVO4GTrU0YEyIJaP24glIwdsGyeFnzCZkbY65QvYUX
         WyBgP2sHIKZprWz3g+Y1GR+pLsszd1w/mR+aB6MV84sWC2FglQvbH9NHt2aIbWdAt3S1
         n2DfSI5vb20+eZdbxXV8pN14JZwDUYA0avReCjOCbbjaPUEPC92MF1nzM8xYSWQUM6Aw
         GT60bmMQdpzCgJy1DSkfsiFZAUJA6Eh1hJWYBIHO9gUsPehxxuHNeseKX2FudE4KMRvd
         DqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=n2YecrhMymln3awuXJw++CHN4dPWLrsnfS2HnN0/bEM=;
        b=TFtzYOCEzcuiA7lHHbjHFAhuPwFo9Jr6gYIdP1KL1kkcXPRPoijan0PhPB037aMg0s
         BqqqI1iv9SOmZjPmOQjd+oyJ0qyajiuemhc69g2ct7cOo5e2valy5bws3XYEiaVofaMV
         C6KgT+b/YgkpMof3zBjbODPgwWEdOK0s4oirlbzL3AfnZ9zvMTIpqKeiyZuIlpeUzS8g
         V7sYH3yz9oixS0UDOOl2MvcJx0JaU45uhKTJqlEqo8NbI6lSujfCCWyUaG4vOiuwZFaN
         2smSqBfLMTArEUt9BOZJUpMTJsAGJaM3QwEpd8bawE1LznmL7SdDhU5uCHDcpEFEIpLi
         i5DA==
X-Gm-Message-State: AOAM530GFpX5veFLPJctyQlx7C6dsFVhCZHJ9pZIQvhkj+GJIHrxjcmo
        3uQPDetkQnnUCQGYIqi8KN1B95tUhGcbo5ES7DE=
X-Google-Smtp-Source: ABdhPJwlQCX5bDLg5XVgnkNSlbdoZHXrZTw2H2lyRLhJgUr3DxjfrQFMuqCH0+rhbnzGlgfXS6MgPAhPfUkfRUoA620=
X-Received: by 2002:a2e:8942:: with SMTP id b2mr1461882ljk.441.1601394606304;
 Tue, 29 Sep 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200929091112epcas1p47da3938ff71bcacaa2691f158a471289@epcas1p4.samsung.com>
 <64750b49-15be-7d51-7ae9-cb1dd4092fa4@samsung.com> <20200929110509.GA1160194@kroah.com>
In-Reply-To: <20200929110509.GA1160194@kroah.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 30 Sep 2020 00:49:29 +0900
Message-ID: <CAGTfZH29J6m7WOZ4xtw7ZvS2MewEOXuRijebQdi0CkzUcWjixg@mail.gmail.com>
Subject: Re: [GIT PULL] extcon next for v5.10
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On Tue, Sep 29, 2020 at 8:49 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 29, 2020 at 06:24:23PM +0900, Chanwoo Choi wrote:
> > Dear Greg,
> >
> > This is extcon-next pull request for v5.10. I add detailed description of
> > this pull request on below. Please pull extcon with following updates.
> >
> > Best Regards,
> > Chanwoo Choi
> >
> >
> > The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> >
> >   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.10
>
> I get the following error from my scripts (which match what linux-next
> will also tell you):
>
> Commit: 00a29c98369d ("extcon: ptn5150: Do not print error during probe if nothing is attached")
>         Fixes tag: Fixes: af71b7e384cd ("extcon: ptn5150: Check current USB mode when probing")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Please fix up.

It is my fault when rebasing the extcon-next with v5.9-rc5.
I'll send new pull request. Sorry for my bad

-- 
Best Regards,
Chanwoo Choi
