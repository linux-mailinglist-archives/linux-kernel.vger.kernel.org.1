Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983492CCDB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 05:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgLCEDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 23:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgLCEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 23:03:13 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E8C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 20:02:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so1351966ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 20:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRmp5HqhPLGN2wPmX9L3DuKRGCI0S5P9+p2ESlsHTAM=;
        b=yM+hbwJ36D/TYAUeZ3O30jzREK/jVR9brUei9BDukg0w08FYtWh/Qug2wO456yLgfp
         jvHp+FbGBpkWrruqNUc3XB6SJWEUTLLPyZJ4NoAqIkivZtDl7g84h2I+qh1Tc2UKG31Z
         aYZ+UsaUDuCh2hoTASBZ5lcCOyi3uvnJrRqljImr+pOuXXpuinuHcix1AIcPAxNrguu+
         qesnH7oIXdcSMK8jjQgB/QG0+6UmLu778AuIc4GNUMQwhSt+lywOyZ73AwLIHkV3x07C
         PiPpfKMPOAxajoZuDN0ju+w3mq29U1gpopsr28rpLlVJBLayNGhOktN7I7QmQMJEcviB
         BJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRmp5HqhPLGN2wPmX9L3DuKRGCI0S5P9+p2ESlsHTAM=;
        b=gPR7CRi/nn+nSSn6qF2dp04yjYrUCCmbYJuzjkZRMUc5r7hZ7QL3QQacCpfVdm56cW
         +E1/+wC7B02cgILXrk2XhvHF+OJKacL1D38Z9H47PURdgX+VBklQQIZzPv0OFeChe7+h
         L4howFdbCID0I9/rwUg6NJyCnkLxwcA160QJ+bnvwiTXfMdgf9Lrf3ilndYQzFmKroOe
         Sim0FAsDvjVpEHeDD3tuD16tLqJztRsJAaGVTE8XGIxa7gkUWkA+8yCi0w+DlsJeC6dl
         G3d40MBxIsUT3c6EeeWwyRVGlpwpvjpvFzuf69j+rnwgDwRdr8L8I9sFFU5Y6Wn7mSCJ
         aNgw==
X-Gm-Message-State: AOAM530bWHTPCw74K95FbO3A6Gc/OY0MYNIn82nYQ6LSyi3h6nJ0/nwP
        jdPK6Xz4Rm8MjvkWJu6tWlqi8ItmhXpoHdnucSZpqquVHks=
X-Google-Smtp-Source: ABdhPJz8lTotrwgwkMAe4sN9k99aQ0CNk+3DhdhJIcU2FwxmpkrPaO+HwFYlT1nUoFBGEPS9/e4cQ19zU35f5Fedh28=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr887972ejk.323.1606968151661;
 Wed, 02 Dec 2020 20:02:31 -0800 (PST)
MIME-Version: 1.0
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
In-Reply-To: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 2 Dec 2020 20:02:27 -0800
Message-ID: <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:44 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Hi,
>
> there was a bit of debate on Twitter about this, so I thought I would bring it
> here. Imagine a scenario where patch sits as a commit in -next and there's a bug
> report or fix, possibly by a bot or with some static analysis. The maintainer
> decides to fold it into the original patch, which makes sense for e.g.
> bisectability. But there seem to be no clear rules about attribution in this
> case, which looks like there should be, probably in
> Documentation/maintainer/modifying-patches.rst
>
> The original bug fix might include a From: $author, a Reported-by: (e.g.
> syzbot), Fixes: $next-commit, some tag such as Addresses-Coverity: to credit the
> static analysis tool, and an SoB. After folding, all that's left might be a line
> as "include fix from $author" in the SoB area. This is a loss of
> metadata/attribution just due to folding, and might make contributors unhappy.
> Had they sent the fix after the original commit was mainline and immutable, all
> the info above would "survive" in the form of new commit.
>
> So I think we could decide what the proper format would be, and document it
> properly. I personally wouldn't mind just copy/pasting the whole commit message
> of the fix (with just a short issue description, no need to include stacktraces
> etc if the fix is folded), we could just standardize where, and how to delimit
> it from the main commit message. If it's a report (person or bot) of a bug that
> the main author then fixed, preserve the Reported-by in the same way (making
> clear it's not a Reported-By for the "main thing" addressed by the commit).
>
> In the debate one less verbose alternatve proposed was a SoB with comment
> describing it's for a fix and not whole patch, as some see SoB as the main mark
> of contribution, that can be easily found and counted etc. I'm not so sure about
> it myself, as AFAIK SoB is mainly a DCO thing, and for a maintainer it means
> something else ("passed through my tree") than for a patch author. And this
> approach would still lose the other tags.
>
> Thoughts?

How about a convention to add a Reported-by: and a Link: to the
incremental fixup discussion? It's just polite to credit helpful
feedback, not sure it needs a more formal process.

Along those lines, how is this situation different than the feedback
that helps improve a patch that does not necessarily get credited by
Reviewed-by:? Links to thank you notes in cover letters seems more
appealing than moving more review / fix logs into the main history.
