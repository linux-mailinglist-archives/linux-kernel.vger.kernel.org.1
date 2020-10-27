Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83B29A2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408514AbgJ0Cy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:54:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbgJ0Cy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:54:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id o3so7180800pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZF0W4dH550EVE0uGKIEMc2tMXwcFBBpVdPSQqA2FHM=;
        b=2MAHbHx0ohuPXh5dfEpWBJ1Wo1XpSybr0ZIK4nZml41vCIF1vUACcWxDhu7y1Ip5o3
         m0rAzVo+jdRzscmsBgtSK5F2nx6US1AxlWhQAtnUMWANCNouKFShn7mkLrXt07PIt+29
         Ae5VD9TY9vxoo8dkcC9NTOiEL8Jr88c0iFX8/xL9Pn+lGm23m5Rz1+DzuC8XTfFkVtKJ
         6fUnFqiZ1EIcmk31nj/CL5qhZHrS0vi1keWT7Yy464+gAY9EObA83xx5sJFakBU8kQHf
         18UOHryCI9Z/tLR3iV4lE1PlMYz1Txi+ifXGpBBrSLRLHYt0eNPb+u2WnrovgJpikVhS
         0R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZF0W4dH550EVE0uGKIEMc2tMXwcFBBpVdPSQqA2FHM=;
        b=WwfshQWt78/gdoUazxFyW0lnE3tOERu+o05mD8BOp0rK6fU4AgAC/gLlUaOKeTh8pO
         CtwgobQDelJ/GMM7YBgIthj9zu+Uyl6Ye6px2DA026gpM1ee8DNoBVqltvsdp3+r0pHR
         J8UARBdUCW73y41Lp1xDGiJ3FgD5Eo2gr8Fw0vXbwoZKhAfrwGOb0d+iHVm0VunhURW4
         r6cYhAqo6GWTjNDXRadVCcJ5lJtzAXIi+M2DItghlQWaD3B6lS5cCWn0fJYW6ISX5UWk
         2jLKAiT8G1/ommsrHK2zfWsUxALbbxh4IxjFE9VKbqyJu6PGalstlq6pggaMahOHykh7
         45cw==
X-Gm-Message-State: AOAM5306VqlN/0h0giC528N1BqQCTWYMQjY4SdMhyJ3cPsd4Iwo7zxDd
        Jz3o172Othlb5TV/tOreWvSOYp4G9bf1sfR/N79gow==
X-Google-Smtp-Source: ABdhPJyUXYA2QbO5JVQ8aPVZ/qUZFKpo5APz2TO+UBNlY/I1gMKpDxJkGfjqKKIr9iRX+x23PthAvtxpgrmzfwJVtsM=
X-Received: by 2002:a63:c851:: with SMTP id l17mr21924pgi.31.1603767295050;
 Mon, 26 Oct 2020 19:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com> <20201026155351.GS20115@casper.infradead.org>
In-Reply-To: <20201026155351.GS20115@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Oct 2020 10:54:18 +0800
Message-ID: <CAMZfGtU4VQ08dnxNBsFfxVEnuOZauOhGSLQpi++3fngc_qNqXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 00/19] Free some vmemmap pages of
 hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 10:50:55PM +0800, Muchun Song wrote:
> > For tail pages, the value of compound_dtor is the same. So we can reuse
>
> compound_dtor is only set on the first tail page.  compound_head is
> what you mean here, I think.
>

Yes, that's right.  Sorry for the confusion. Thanks.

-- 
Yours,
Muchun
