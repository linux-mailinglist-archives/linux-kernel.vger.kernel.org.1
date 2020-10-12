Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19B528B591
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgJLNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388684AbgJLNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:10:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D217C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:10:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so17624544ioo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=ECw5bzhSCyxuQlk/zYdTL9hZWuUWFH2UmH7qybfKxvQ=;
        b=TfAdQ7XkO56MzJ/poXHQPPRsu7qQZfNllHrCt9mZx/SMBQ9PvLEJgmROL23QqZds8w
         l88sa8T2aXgSlakMFon+XITo2Qx0+wzblHPnjqfqiW6NbOz46cAEOE1cfuLnzIiw4rPT
         r9Q+OE/OA9ZhHjaLyRK+SFyyHw6EqgW9qp/SNmlQzvb4/3hB1Az1uz7m3Z5Mlj3bWCFT
         C8zZaoBLKjJUZpA9uLUSaEF+YIM/6zcjy6KdeLA6qKRlZ/+2tfW0QmFIbXC0ULCO0Rbm
         IBZPacQULmZxRTS33xrduWjD3YNR47/y4DOOWTTBbKkk35wVUc7HAnYbcqww/lqidQLU
         sw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ECw5bzhSCyxuQlk/zYdTL9hZWuUWFH2UmH7qybfKxvQ=;
        b=cFgn/Sppze35jUNrBLfAX9yY1smxtc6CcBjsAVOnrT1VVTzpsjgBXEXcIUBSe/70qG
         UFjaSTJGNKZ0Y8hq1eCMieoDlFWQONJS2zlezhH//i0cYe5Dr0+cCsJrhhlLA0gk3h+G
         iIetkr1zeJuGdZJ/CwaKrKFE8ADXC2/AclF+fbyYgJvWMa46kQ+yID7Gilf/ZynX7gpl
         H0qqZvu1dIZP0tukExx/Nd9qAvfrmN00SkCyPHMFjXTYdKnkq/pRXfopObM5ZsxsErYe
         mq3ndViWhFXBXsesJKMaOP+tMx5I0F31HHqLNXg/B1N8QL54ySlxFEyqoJ7pge8rHOf1
         0FOA==
X-Gm-Message-State: AOAM532jPlRJKWWpM0wZOTGp0RJSnSWec9Om2dwYvymTGO4mO/wjpX5b
        wJrr50+HQxeF4WzWqSQ6HytAPXgjML+ymMJXLHn0GwRmBRiohg==
X-Google-Smtp-Source: ABdhPJxpjWGowQanilPP0doPZ1xgDf+LIY28UcrdtMJBXCwOcLjJAeayzY1GaafkeWpCi1qjDQDAucrZaEnMla8FPq8=
X-Received: by 2002:a6b:b841:: with SMTP id i62mr16741492iof.57.1602508208829;
 Mon, 12 Oct 2020 06:10:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 12 Oct 2020 15:09:57 +0200
Message-ID: <CA+icZUUK3sgpHyY1h_pdzJzkX1bY46opLYytRKRzeCxBNzTX4A@mail.gmail.com>
Subject: Missing [GIT PULL] request for <tip.git#locking-urgent-2020-10-11>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yesterday, I saw Ingo tagged "locking-urgent-2020-10-11" in tip Git.

Did you drop it or was this for Linux v5.9 final and the git-pull
request was simply forgotten?

Just curious.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=locking-urgent-2020-10-11
