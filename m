Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9102E2B3F22
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgKPIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgKPIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:51:24 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD96C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:51:22 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z16so15257183otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zy986Vg7ccKVkvtXBhD6NQzZqFrJZe4eCvqprIanDG0=;
        b=JuvqGj0Cq1pYlbEVb8edLk08OVHo7+rEVlDBsptQd/hn5A8VD/z31ibnpUBhIXBNyL
         HNn5+9FdCObQmigZ8uLvav50NVbvNFRC9O19XcnaaQqx1+IsxlVooo0JWWdicnHqYRPd
         O60q+ykj3LZ1M/DUSjYmpfDTQr+ajOpoW9PNSgIeVpJv48KSMcsCiCzBVI9kawoz/XGV
         efmNAyL8UwvR80V6O7jmT5CSBeE1faIXkrdFvIzk/976avizYp9YzCKo2ZC8pZHhejST
         98BPsM/MmUhowaR9HpLQR3CnEiQsneuUs5uVHinz9LXv77QUPRbvQ8iXfL590xZxITDa
         QMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zy986Vg7ccKVkvtXBhD6NQzZqFrJZe4eCvqprIanDG0=;
        b=JxCh7rZJU1ukD/uN/JbK2EfS3lIt0r7jFtCBHlKosArirtsbkWQ0eMUu2lhydhjHL9
         NA2Drrm6xdeMoNGyyVKoqS966k6SqUZQ5jxQX/QErr1w0j4a213svyovRX24iIXv0eMW
         WWWIZpp+m6LqDJrpgbYxyQwOZZlZRM6ewwVI605wu/9KGyF3mdv9v189a+4jqc4cCEF2
         ED3YUwLCRYD8dZmBTa4meWWw1QosGQFR25tusLosdBCeESaDnp1kxVi6jMEWjOpTb24V
         39MIK1bvaEGG9k/IzLiobXB6+GNwg4J3eQbxDM+sBb6GnheDM1lcw7fg5IiK23Hn5tHO
         aPAg==
X-Gm-Message-State: AOAM533Xe6WDj4O0Pvk/to48+JvWINPGBiM77x6K1JFsYLL+hYp1hvAp
        88kQna+eMhX/CdlozGpb+xp9VZNX3WJTd6/w5D2j5KvjwyySjw==
X-Google-Smtp-Source: ABdhPJxWqcHBPYeajFVaGU7tSqABIWYXYXCXbbVxcowZAb2uCyBxqne0TTXqMUeS+JM5WohSWNy5mOuTmBdCG4wf8os=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr9315212oth.251.1605516682127;
 Mon, 16 Nov 2020 00:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <20201116054150.211562-1-98.arpi@gmail.com>
In-Reply-To: <20201116054150.211562-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Nov 2020 09:51:10 +0100
Message-ID: <CANpmjNP+4ckx+ZgkQkicA5GDDQ=NzSGiSj6_bv13g6biz-kDcQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 06:42, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
> Changes v8->v9:
> - Replace strncpy() with strscpy() in timestamp_expectation_to_desc()
> Changes v7->v8:
> - Replace strcpy() with strncpy() in timestamp_expectation_to_desc()
> Changes v6->v7:
> - Introduce timestamp_expectation_to_desc() to convert param to
>   description.
> Changes v5->v6:
> - No change to this patch of the patch series
> Changes v4->v5:
> - No change to this patch of the patch series
> Changes v3->v4:
> - Modification based on latest implementation of KUnit parameterized testing
> Changes v2->v3:
> - Marked hardcoded test data const
> - Modification based on latest implementation of KUnit parameterized testing
> Changes v1->v2:
> - Modification based on latest implementation of KUnit parameterized testing
>
>  fs/ext4/inode-test.c | 320 ++++++++++++++++++++++---------------------
>  1 file changed, 164 insertions(+), 156 deletions(-)
>
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> index d62d802c9c12..7935ea6cf92c 100644
> --- a/fs/ext4/inode-test.c
> +++ b/fs/ext4/inode-test.c
> @@ -80,6 +80,145 @@ struct timestamp_expectation {
>         bool lower_bound;
>  };
>
> +static const struct timestamp_expectation test_data[] = {
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 0,
> +               .expected = {0LL, 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits =  2,
> +               .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 6,
> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 0xFFFFFFFF,
> +               .expected = {.tv_sec = 0x300000000LL,
> +                            .tv_nsec = MAX_NANOSECONDS},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 3,
> +               .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 3,
> +               .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> +       }
> +};
> +
> +static void timestamp_expectation_to_desc(const struct timestamp_expectation *t,
> +                                         char *desc)
> +{
> +       strscpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(ext4_inode, test_data, timestamp_expectation_to_desc);
> +
>  static time64_t get_32bit_time(const struct timestamp_expectation * const test)
>  {
>         if (test->msb_set) {
> @@ -101,166 +240,35 @@ static time64_t get_32bit_time(const struct timestamp_expectation * const test)
>   */
>  static void inode_test_xtimestamp_decoding(struct kunit *test)
>  {
> -       const struct timestamp_expectation test_data[] = {
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 0,
> -                       .expected = {0LL, 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits =  2,
> -                       .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 6,
> -                       .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 0xFFFFFFFF,
> -                       .expected = {.tv_sec = 0x300000000LL,
> -                                    .tv_nsec = MAX_NANOSECONDS},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 3,
> -                       .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 3,
> -                       .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> -               }
> -       };
> -
>         struct timespec64 timestamp;
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> -               timestamp.tv_sec = get_32bit_time(&test_data[i]);
> -               ext4_decode_extra_time(&timestamp,
> -                                      cpu_to_le32(test_data[i].extra_bits));
> -
> -               KUNIT_EXPECT_EQ_MSG(test,
> -                                   test_data[i].expected.tv_sec,
> -                                   timestamp.tv_sec,
> -                                   CASE_NAME_FORMAT,
> -                                   test_data[i].test_case_name,
> -                                   test_data[i].msb_set,
> -                                   test_data[i].lower_bound,
> -                                   test_data[i].extra_bits);
> -               KUNIT_EXPECT_EQ_MSG(test,
> -                                   test_data[i].expected.tv_nsec,
> -                                   timestamp.tv_nsec,
> -                                   CASE_NAME_FORMAT,
> -                                   test_data[i].test_case_name,
> -                                   test_data[i].msb_set,
> -                                   test_data[i].lower_bound,
> -                                   test_data[i].extra_bits);
> -       }
> +
> +       struct timestamp_expectation *test_param =
> +                       (struct timestamp_expectation *)(test->param_value);
> +
> +       timestamp.tv_sec = get_32bit_time(test_param);
> +       ext4_decode_extra_time(&timestamp,
> +                              cpu_to_le32(test_param->extra_bits));
> +
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           test_param->expected.tv_sec,
> +                           timestamp.tv_sec,
> +                           CASE_NAME_FORMAT,
> +                           test_param->test_case_name,
> +                           test_param->msb_set,
> +                           test_param->lower_bound,
> +                           test_param->extra_bits);
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           test_param->expected.tv_nsec,
> +                           timestamp.tv_nsec,
> +                           CASE_NAME_FORMAT,
> +                           test_param->test_case_name,
> +                           test_param->msb_set,
> +                           test_param->lower_bound,
> +                           test_param->extra_bits);
>  }
>
>  static struct kunit_case ext4_inode_test_cases[] = {
> -       KUNIT_CASE(inode_test_xtimestamp_decoding),
> +       KUNIT_CASE_PARAM(inode_test_xtimestamp_decoding, ext4_inode_gen_params),
>         {}
>  };
>
> --
> 2.25.1
>
