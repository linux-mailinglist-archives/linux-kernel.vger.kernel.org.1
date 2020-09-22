Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC9273B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIVHDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgIVHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:03:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C20C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:03:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o16so18022982qkj.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=bYsUH0D1byl7OQrrZQ+xdlJruk3Z9J7VpOvGu3fFAWWZ/Asg1P90smolbRStt9L+xM
         WBMQ46yQRbtqZESuCdUfhHiBv9rwZuAYpul9NwOEdJ+epPnbW1+2DtRJLaSrpTp0CH+k
         y2v4yR4sHmtSvewoKcw8ZL4Ap8AJ9nZhN705OUU6ACF8cTNgNshlhklZ61FTFs3iz6D1
         HEbCayhPdbgSizhB9X97s5Z0OOZ/O9VQXhr085rkCnKJjT2O7BvopzHwaEVqYQ4SY9k0
         RuLusJGtCwf8zltcQuXLV6UQXF6TJw+FgJw1UrxNsCjlmGw/qI4w79xcjwSEtMf3hxA1
         Cunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=RrBgaWtiQSwovasmL76FXgtRu34N6qeTR/E5iebwtRrAP1TmgXFWeVmQcSvMcz3cvL
         LXgbF9Lq/v4chqgwRAARJ/zYtXEg0ohMpcZzkdkdO/Ij+fybjUWytD/4wSwST9ggbvEN
         EwnqGifU7oS6PsACX2STSXMuBezQ1GaVfwHKtcSIrDc8WZ3sOFRD8mcIT8O2ELFzmAR6
         COpIgQOX/f78ddbjNBf+tcuLUEc408FqtibbacUVpDNeaJQpaMNi3Co3JLoB4vejKnI4
         71Q2OiFmap46RZQUg401HAJhyGjQ2O2G9UaCNQ0x3mNk5ycDDPdEJaDyw/4zwohSvx3i
         2ILQ==
X-Gm-Message-State: AOAM5328gKa5TLzJ3HADVQ75bm/uavaI2rmQt45AY+Tpz4ZOXrnc4f1z
        7G705PJRbf5WcpZ/Ri9AGAAOwUQfcZqvhzU7ZGU=
X-Google-Smtp-Source: ABdhPJw7gxDI6rqnh8y8rR7eDp9F9pSlNdBzZgGtA2yDvVfObDkXOhuDM+zn6nmS4ah7VJK6i2U1jbikow45vb3j974=
X-Received: by 2002:a05:620a:c97:: with SMTP id q23mr3592665qki.168.1600758186117;
 Tue, 22 Sep 2020 00:03:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c341:0:0:0:0:0 with HTTP; Tue, 22 Sep 2020 00:03:05
 -0700 (PDT)
Reply-To: sararrobrt@gmail.com
In-Reply-To: <CABvoT3TXtw4jQ0aC1GxfJT7bqdudA7dFY5sXzye+3f7ctoBeqw@mail.gmail.com>
References: <CABvoT3QXJ9+Bb64s=MMQG9bW3-LmM0TR0M2zYzfbjeAT8cEF9w@mail.gmail.com>
 <CABvoT3Q0mAXYuFOK5MQ528KXeuCmqvJXP2AYdZygwFKRr8q5uw@mail.gmail.com>
 <CABvoT3SqgCJ3FSxtyWNgPQUoB9EiqZZ09jPOA7SVJijUm6Urjg@mail.gmail.com>
 <CABvoT3R8jC8EKXX4VqPp0bMBcTmnAneJre5k_gLQaFOudEVokg@mail.gmail.com>
 <CABvoT3QT-bD4e1vbqXN5Xdgvky3rGY3A1HtZ-FNqJvSj8QiTRQ@mail.gmail.com>
 <CABvoT3RNqVLA22asgwjAA7c-jG9OZZ34DyJ1P_nuRTDHLhrN_w@mail.gmail.com>
 <CABvoT3RbxNjtkGxK7JDUqwnAs7cDFKKUMX_Yh=91oEN=Joxz+w@mail.gmail.com>
 <CABvoT3QmqRLgh9FXPb9XvqyoCQeEehZ8L4_UR9Vft=dxTi8bWA@mail.gmail.com>
 <CABvoT3Tc3K=yDEQ=8ptdiPHGEuPPZ_tpRUu9_VK4vxnbLyPn6w@mail.gmail.com>
 <CABvoT3TOUx24nYV1HS8V7Nj8iNYe_1RDv0E0jkYq7dU31B7bpw@mail.gmail.com>
 <CABvoT3SCjcc0WghsjuaaVbBohcOSsFRkb9rJD-4UBqBi50cimA@mail.gmail.com>
 <CABvoT3QYoWxbFyAoQ3BbBW5A7JTOBkuaC68ipPLJauWSa2uphw@mail.gmail.com>
 <CABvoT3TrX3f=pMgujVnr9rV9EgCbGcHOymCPikykEK2HC4MCkQ@mail.gmail.com>
 <CABvoT3TG=1U-W5GVrCMu0uCpFRKYB-k3zu14ALuZJF4rg909ww@mail.gmail.com>
 <CABvoT3RQnsCtUROxpSMoxnAZHfiR6qy+_36hNbfCqUXrXrc0wQ@mail.gmail.com>
 <CABvoT3Q27Htne-Eg_K6MY2YDZNDdXp_Co0UmVjQFCDkk=MR9Xw@mail.gmail.com>
 <CABvoT3QuNm-t80VxJ-3nYif4OtFfRoU6Ku2ysM22EZdBYVWwRw@mail.gmail.com>
 <CABvoT3R8cGqzsytOFNOGE0JPG9==aGkVCu8JwmkvqPihomCL4Q@mail.gmail.com>
 <CABvoT3SfMr1SaE+7ZdrJi7Wh82a0D7_P-UgbXpiA6HExcuzTzA@mail.gmail.com>
 <CABvoT3R+S0ZQdsO6yseCQrhNpkz+kicYPFVhSrrRGQTFSkerrQ@mail.gmail.com>
 <CABvoT3R6f_JHivhUA09F55K56iEo5tYmhLtdgXZnxfMEREoPpQ@mail.gmail.com>
 <CABvoT3R5XyuPQ_1DKpRvn2cHcZec50C21A7WFGOmjL9RxJYX7w@mail.gmail.com>
 <CABvoT3ShFa0+gCVcUbfbEJTYXRGpBxcpvwKMAfwJEo2535X_yA@mail.gmail.com>
 <CABvoT3SOr+LLeAmkzWvd4=ADrfQytshNoo=G2D6TAy3T0Rtf0g@mail.gmail.com>
 <CABvoT3R1v2umamxQmj4-z91AvF_XtVzGYRzXqD4wH7=x6G1GGw@mail.gmail.com>
 <CABvoT3RhAtEZ0WeZu99vcAQu5ZjxRSxoG_Fz9YG6ykFE0AEpdw@mail.gmail.com>
 <CABvoT3STapwY79j1-4=_H8vpKfvmOpYOuwuYtNN9FNUEpt=AVg@mail.gmail.com>
 <CABvoT3RB13LSm2g7UeyfO0fqRASq_W7OQbE1mZmt4i4TjzZDRw@mail.gmail.com>
 <CABvoT3Ss6_iBTgx3JE3mCWPC3upq85w4thbzjwT5wQ5B9v0Udw@mail.gmail.com>
 <CABvoT3RzzB-v+rp_5=ngn9grJDH_5DxOpKefcYiW5=R+YpNO0w@mail.gmail.com>
 <CABvoT3RkyLaVvhDzqn5T78y=Fp5RCBc9vSo7ChdpmY=p80u69w@mail.gmail.com>
 <CABvoT3RmpYB25f6u+gbJfTuNvwOUCgjcVaoOtsRqxmQR9Cvejg@mail.gmail.com>
 <CABvoT3S8gC1Sg8=Bh5WxeUe+8HasXh_V5QmgC2sG-bAKap3WCA@mail.gmail.com>
 <CABvoT3Qa04JUmDMnJrS_BGieGj+U5JHOZO_i+=ox5mq8dg6peg@mail.gmail.com>
 <CABvoT3SRCOxKjpukmgu6_X_+2R-OLyKAYPo26dR3D35G_qOLkA@mail.gmail.com>
 <CABvoT3S7CtP+MjD9cZQ7F4hY+m6wp84V-qQJZXW+n9JW5WqyQQ@mail.gmail.com>
 <CABvoT3TcR7TptvTLL8Lqbjd0U84yy34HfurpHr-auNoPkrS8Yg@mail.gmail.com>
 <CABvoT3QZok2doTmEcJbVVm5MLkg9LRPtvbMJL_eQh4DAoozrGA@mail.gmail.com>
 <CABvoT3S5cc5xJjRS5PLC-iCqbujrbCKkmPCmbHoM3dty2xt9NQ@mail.gmail.com>
 <CABvoT3SN5eow19KKM+7+L2zRaa9Pd=KDaV1FmKheLU_XersaqQ@mail.gmail.com>
 <CABvoT3RXZyaZaYypVNL9yuyQnMptWrbcoNfa8qzD_s6pfgi34Q@mail.gmail.com>
 <CABvoT3T7XiNQzptCtc4-LtrFm7b28gjmVmW0gEAML8y96z6NkA@mail.gmail.com>
 <CABvoT3QLfaoQW4bssmXqkOPCxTzy+J_DzkyTV8jgXQENRcQN6g@mail.gmail.com>
 <CABvoT3Tdb2-pVVFm-Sp-PFeh4mQDZ=CB+z9exmWLn5J6WBS37w@mail.gmail.com>
 <CABvoT3TtkgN28ZKfL4awmRrVwu9k2TvXV9JnK70M6mbAc20a5g@mail.gmail.com>
 <CABvoT3RkrzE299w5L5yxWOAcvrpJdj72OKuusjsOGy+Zi96rKg@mail.gmail.com>
 <CABvoT3QhU7cH0hcKhnaBHSRrh8Dzj2iysbkymh-9gB67Zb+5jQ@mail.gmail.com>
 <CABvoT3Qa-O-tiOe=RXfq1MoZuoPBHsnymePNPbuPfGMhLd5eGQ@mail.gmail.com>
 <CABvoT3RVRLX-BBK7n4NoOXD4g=o1Y=q5zgFugigcw8VPaqrqNg@mail.gmail.com>
 <CABvoT3S5v6PuMfhTvk5Mik+-33KNLio+JxneNBB3ZqxfrdbX=g@mail.gmail.com>
 <CABvoT3RJkG2utXgbcd+m9w1A+MhVf5T-q7v2oxE1UroJS=8tXw@mail.gmail.com>
 <CABvoT3RMC2bQCofnACZEwqp9kFpjJkdP4OtBrgaDWveVnzsFKA@mail.gmail.com>
 <CABvoT3SVq06o4XTFJ=a=vEdCtKa7B=WfYMJmiQtKvMc76sCd4w@mail.gmail.com>
 <CABvoT3TXG_w=fbQLWhh3bgd7AnvQSvs0djN1_54RLG+aMuHs0g@mail.gmail.com>
 <CABvoT3SU8cwQwyaMqLyw57pi_hd1c1XbtbuXPqupc59O3GKo6A@mail.gmail.com>
 <CABvoT3RKG19VDqv6+iyrr5nU4MQ=T4TwuWPvpoEz1s-uR6F+DQ@mail.gmail.com>
 <CABvoT3Q9AZWHPXVdsAVdUBg1=dLM9Jyhka0DP-S_LeYQNPGwJw@mail.gmail.com>
 <CABvoT3Rrjbrbb=U7R2orKhEfF9i2j49S1DADtW+gZimVK2uhvw@mail.gmail.com>
 <CABvoT3TjFQtTNOKEAKNe2kLejfq8iF9n+=E54LQjbt0H01dL5w@mail.gmail.com>
 <CABvoT3R821p1Mf9ZnNLoRZYY198dLbZj6RTod4EB-Na_QYw4CQ@mail.gmail.com>
 <CABvoT3RGkvOqrOy4zj1e8u0SYg471ScXaLS+nx8SbFH-fDTaGw@mail.gmail.com>
 <CABvoT3SMfdQoO09zgjC3Y6ZNtLN6DofJWmbrtHkAi5Z=PpivsA@mail.gmail.com>
 <CABvoT3QxZGVb0PbPdUcVYhMiPk76X8E+OeU+N5xsJS5jdyi4Vg@mail.gmail.com>
 <CABvoT3TaYQwNDdVBh-TU+u1oFjUyMtB2Er6dxnzHQH633oJdDg@mail.gmail.com>
 <CABvoT3S=M8jZQ42AfOPoNEm9C2Y=Vn=Ds_4e03hZO-FTdXOVkQ@mail.gmail.com>
 <CABvoT3TSwF8L+doqcH3a7pOJ0OfrYL9=WXWLsPD6Eao5af1pZQ@mail.gmail.com>
 <CABvoT3RPODFJ4Mi8Tu7z1W6Tx8cX_zn1MVy0PoUjVeFh9wpyvg@mail.gmail.com>
 <CABvoT3QdDfiKgJL=ZvE1U0w3wdUXbVCjbCgKdm1R4Orq=RPObw@mail.gmail.com>
 <CABvoT3SbTw1NetLLXUUKoj0EDyqX6XoZBasxP7HTcNix-8k0ZQ@mail.gmail.com>
 <CABvoT3Qkb8t-1kq5BzBzwSjiB5=HRrNAyuxrS3uLdNo3SAQp8A@mail.gmail.com>
 <CABvoT3Sc_Tg6Lu57J0dErsteNinV-upCfFhS=eJ0zMaas9K-mw@mail.gmail.com>
 <CABvoT3SRvG2BLZwdU6=dpsAcPcK1jnBy=PJb0L9Xo1vBc2HSeQ@mail.gmail.com>
 <CABvoT3T4kUTWeAvTrJw71YuP8OR9FX3EsU9CTPzs5fkc5eHNFg@mail.gmail.com>
 <CABvoT3RbdPOUChWGWCh-XdPy+qHO11Z_m-PxZh3CkjubdV9WDw@mail.gmail.com>
 <CABvoT3Sk72ockFFriWWog0L=rBh3cTjEfHPzK7b4nQbdpVxoog@mail.gmail.com>
 <CABvoT3QOrfuR0FG_qwfr8-2OoiC6EOHbSrKn_Hr==DngtJe2yw@mail.gmail.com>
 <CABvoT3ThkmveetUR8PE32BR8-Bh6_nfhN1YEvH4ZR5_ZyZ1icg@mail.gmail.com>
 <CABvoT3SvEHNL_GUOUoy2qs6MiRJPf-mW3uu_0uTMgQR_dSv2iw@mail.gmail.com>
 <CABvoT3Rr9t56N79BkJ54gBbye4i=gCE-A6=2dG=vvGX32fQecA@mail.gmail.com> <CABvoT3TXtw4jQ0aC1GxfJT7bqdudA7dFY5sXzye+3f7ctoBeqw@mail.gmail.com>
From:   "Mrs. Sara Robert" <mgary7143@gmail.com>
Date:   Tue, 22 Sep 2020 08:03:05 +0100
Message-ID: <CABvoT3Q+KFvh-o4AAstUw=-nJucBLU_p6wQB59cjLjXJ9PYOZg@mail.gmail.com>
Subject: Greeting?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear,
I'm Mrs. Sarah H. Robert, 77 years old dying widow from Australia;
that was diagnosed of cancer about 4 years ago. I got your details
after an extensive online search Via (Network Power Charitable Trust)
for a reliable person,  I have decided to donate my late husband WILL
valued of ($5,500,000,00) (Five Million Five Hundred Thousand United
States Dollars) to you for charitable goals. Get back to me if you
will be interesting in carrying out this humanitarian project, so that
i can arrange for the release of the funds to you for the work of
charity before entering the surgery theater. Contact me via
E-mail at :  sararrobrt@gmail.com
Sincerely,
Mrs. Sarah H. Robert.
