Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ACB2B5EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgKQMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKQMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:10:24 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:10:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so20082116qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o0jeVSQmzUAmk1xbEshzaNLz0SjmeOddDRU/spmatk=;
        b=qjxtY4L/pSZsKkQwzyQ6WPWLgfbeHzjz9s4p4X2Gvs722PBi6eL1lpTiMJBzQ/va/n
         5ZlaCxDNa9s/U8dqmLJm27888YvgtSPNwjbIn5lrebZu+w4S9cZrMb/JhhYiglVlqdyt
         P+TJNudUVjahKiRKQVMCmAHhSNdHt/BGcbFzjqsWOhnYGc9d5UIfhWUZORc8l2WZLsWM
         c+JWjM6u7kePTGWtkh7shVB9PcMLCoiGRP5KDTa5p+HhncjRFxmWx0JGuweIqi97nW3I
         qZQrINX0bHF7JgnrIUv309t0mFZbMeex58hGvdWWJ5mFL3Lx9dTxHzpdOo7fK6EKL6dH
         NCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o0jeVSQmzUAmk1xbEshzaNLz0SjmeOddDRU/spmatk=;
        b=eI/7w1RvubqSd0xLgFTr0TbsEzKDQRpCEqi7bMOIFB9FWYmn2Tfwm/OIbvQHTGCMIa
         LWiHNm5J/mZv+pPqngn7K5DNtAOJDYooUr0QbeWsoonwbZ5BUOAzaM0sAzXUCpE7tnGH
         3jmnsuBAnKi9EcpZfxHVWgXTOKxChKPM8pS3eXsGCIwNRxfZMK4kZT2XxJ7H66EWWdum
         811mTZ2MlKN6TKmHK9DWWTnJ416aCDoJH8p9q0fQKX8omx1YakW7QMbZfQmMmGgRdCGk
         jOHN9kotpLr3cqsUxA/zfQjHrjFblJ1GQ4g+ZyCun00Z9j25l6KMuvYY2+6Bijla8kRW
         JuEQ==
X-Gm-Message-State: AOAM530Ou8SoqX9bVZ/7FSxAuvdHOLA7TsLlxnCAAuqohoaPlqRg8bXX
        06kXTKwkLxSlRj0DSL4quyx3ScgN5uyoBCxLTBgPWfQDkzc=
X-Google-Smtp-Source: ABdhPJycvwWHeb8fzvv63MFpLzr6/5oraxZLR4rtjnfAvrxrXARcgoeFIsesUsHb924vobxAYepNl0zcIbqyuYX/+Jg=
X-Received: by 2002:ae9:f715:: with SMTP id s21mr18936312qkg.467.1605615022569;
 Tue, 17 Nov 2020 04:10:22 -0800 (PST)
MIME-Version: 1.0
References: <160560676899.144950.4148778261999789656.stgit@devnote2> <160560677952.144950.8229834525319742454.stgit@devnote2>
In-Reply-To: <160560677952.144950.8229834525319742454.stgit@devnote2>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Tue, 17 Nov 2020 20:10:10 +0800
Message-ID: <CADjb_WS+tc-oHX7hXVoWGz9pP_e66DcMp1npKbdpcVa9DhPKPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] tools/bootconfig: Fix to check the write failure correctly
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Fix to check the write(2) failure including partial write
> correctly and try to rollback the partial write, because
> if there is no BOOTCONFIG_MAGIC string, we can not remove it.
>
> Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
For [1/3] and [2/3]
Tested-by: Chen Yu <yu.chen.surf@gmail.com>

-- 
Thanks,
Chenyu
