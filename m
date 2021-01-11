Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF892F1B32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbhAKQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhAKQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:41:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C1C061786;
        Mon, 11 Jan 2021 08:40:19 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id w17so132694ilj.8;
        Mon, 11 Jan 2021 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmHhUoHujwB9690uWJo1Nnc/jVCu3y6M2V7fVUBJOS0=;
        b=Pxb+51SAfh5Z+6jlD/tmi0nwza7s37RH8P63MMciRO/Amr00CtTJ/ae53eIVtKUrhp
         jlm74YUIpvG//77UtmCJg8be5+aw4n+FPxuhjDfO19IBBWhdiRVBT0wG74vtGwU8IgsC
         r2AGscLapRSMztqN2U+RZCCmCFLctfsdGrhBGPaXlLMT4RltAfZtUYhjfvT+oYD2l/gc
         XtHb6d3ixDGF2moLbkdkOQa3K3MI8o0NnJP6X02jJT9NJm7aYD29GpXookHiEtR06saV
         8bbcWGU0PGadvCscxh0/k+Q6aq7Y+oOxd582Xoqwl7GD6XO85tn8lmgfui5ZdSq8dgaG
         Er3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmHhUoHujwB9690uWJo1Nnc/jVCu3y6M2V7fVUBJOS0=;
        b=tKqdt4uP4v7YtuwZCoCrIR55RWuKsQwFpTcqfvrIhATPhhAZ5Gt9SUyiLhbPgIY2lm
         zB8jbG1fVPRgwW/lo3F6ODR5bIXa6wFWp30CDneLjxGLA6LSMQ9jaKN3Pv42vVw0GZvN
         zWq5C1u0rh4YYpe6x2DEEePKTx/pSTUhPXJ2JxupGliEo6mXWIY7gFY0rlzefgtdb+kQ
         LHUo4jS2OvlTVlHtK1N0dP+avZrGLToZAuHNTzGv6RjA+8ifDx2EN7A0ij9xetq80r4X
         +6a4rqpjcjx08e2UqllA4WOf2ZE0HWvxn6yRylvNmFznNKKvqswlEhqfVfDjPlRI+TBz
         gOnQ==
X-Gm-Message-State: AOAM533zLoCIPvvJu3sECct9kjDNs0zYrivA6/gkObzPiaV72W4H/6M/
        /L3fr8bzFyPHnE6vCWJLQMrwOvNtfI2v4juZkTIiuivtsV7Vnw==
X-Google-Smtp-Source: ABdhPJzslw7wNd6k6kL5FnsJZzv6LYDK2TNrg+SHSsrkFU5je5jAGlN6TcV67i9eRZMei32Xej//jk7XGFIg85fcwHU=
X-Received: by 2002:a92:c26f:: with SMTP id h15mr8223378ild.65.1610383218943;
 Mon, 11 Jan 2021 08:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106173900.388758-1-aford173@gmail.com> <20210106173900.388758-2-aford173@gmail.com>
 <c5a97aca-ce74-bbd3-e99d-358e079c4c4a@lucaceresoli.net> <CAHCN7x+gUQwv4cWgg7Jt2oca1n4KW=o08rzoK9TB1Z_rKE0qog@mail.gmail.com>
 <e64a590d-1b3a-73cd-fb93-970013385224@lucaceresoli.net>
In-Reply-To: <e64a590d-1b3a-73cd-fb93-970013385224@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Jan 2021 10:40:07 -0600
Message-ID: <CAHCN7x+NFTn9Jqzbdm7d2UZt68DSAZ9Z-r+7Txwqi1=eE=W3Ug@mail.gmail.com>
Subject: Re: [RFC 2/2] clk: vc5: Add support for optional load capacitance
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 12:02 PM Luca Ceresoli <luca@lucaceresoli.net> wrote=
:
>
> Hi Adam,
>
> On 09/01/21 04:00, Adam Ford wrote:
> > On Fri, Jan 8, 2021 at 4:49 PM Luca Ceresoli <luca@lucaceresoli.net> wr=
ote:
> >>
> >> Hi Adam,
> >>
> >> On 06/01/21 18:39, Adam Ford wrote:
> >>> There are two registers which can set the load capacitance for
> >>> XTAL1 and XTAL2. These are optional registers when using an
> >>> external crystal.  Parse the device tree and set the
> >>> corresponding registers accordingly.
> >>
> >> No need to repeat the first 2 sentences, they are already in patch 1.
> >
> > The reason I did that was because if someone does a git log on the
> > individual file, they'd see the comment.  While it's redundant not, it
> > might not be as obvious in the future when looking back.   Not
> > everyone reviews the history of the binding, but the source files' git
> > logs usually have some value.   However, if you want me to drop it or
> > rephrase it, I can do that.
>
> Makes sense, I had never considered that before.
>
> >>> +static int vc5_map_cap_value(u32 femtofarads)
> >>> +{
> >>> +     int mapped_value;
> >>> +
> >>> +     /* The datasheet explicitly states 9000 - 25000 */
> >>> +     if ((femtofarads < 9000) || (femtofarads > 25000))
> >>> +             return -EINVAL;
> >>> +
> >>> +     /* The lowest target we can hit is 9430, so exit if it's less *=
/
> >>> +     if (femtofarads < 9430)
> >>> +             return 0;
> >>> +
> >>> +     /*
> >>> +      * According to VersaClock 6E Programming Guide, there are 6
> >>> +      * bits which translate to 64 entries in XTAL registers 12 and
> >>> +      * 13. Because bits 0 and 1 increase the capacitance the
> >>> +      * same, some of the values can be repeated.  Plugging this
> >>> +      * into a spreadsheet and generating a trendline, the output
> >>> +      * equation becomes x =3D (y-9098.29) / 216.44, where 'y' is
> >>> +      * the desired capacitance in femtofarads, and x is the value
> >>> +      * of XTAL[5:0].
> >>> +      * To help with rounding, do fixed point math
> >>> +      */
> >>> +     femtofarads *=3D 100;
> >>> +     mapped_value =3D (femtofarads - 909829) / 21644;
> >>
> >> Thanks for the extensive comment, but I am confused. Not by your code
> >> which is very clean and readable, but by the chip documentation
> >> (disclaimer: I haven't read it in full depth).
> >
> > I was confused too since the datasheet and programmers manual differ a =
bit.
> >>
> >> The 5P49V6965 datasheet at page 17 clearly states capacitance can be
> >> increased in 0.5 pF steps. The "VersaClock 6E Family Register
> >> Descriptions and Programming Guide" at page 18 shows a table that allo=
ws
> >> 0.43 pF. Can you clarify how the thing works?
> >
> > I used the Versaclock 6E doc which is based on the following:
> >
> > BIT 5 - Add 6.92pF
> > BIT 4 - Add 3.46pF
> > BIT 3 - Add 1.73pF
> > BIT 2 - Add 0.86pF
> > Bit 1 - Add 0.43pF
> > Bit 0 - Add 0.43pF
> >
> > Because the Datasheet starts at 9pF, the math I used, assumes these
> > numbers are added to 9pF.
> > Because the datasheet shows the increments are in .5pF increments, the
> > 430nF seems close.  The datasheet shows 9pF - 25pF and based on the
> > programmer table, we could get close to 25pF by enabling all bits and
> > adding 9pF, however the math doesn't quite hit 25pF.
> >
> > For what it's worth I needed around 11.5pF, and with this patch, the
> > hardware engineer said our ppm went from around 70 ppm to around 4ppm.
>
> Did he measure what happens if you set the register according to the 0.5
> pF interpretation? Does it improve? I understand the difference is
> probably olwer than the noise, but who knows.
>
> >>> +
> >>> +     /*
> >>> +      * The datasheet states, the maximum capacitance is 25000,
> >>> +      * but the programmer guide shows a max value is 22832,
> >>> +      * so values higher values could overflow, so cap it.
> >>> +      */
> >>
> >> The 22832 limit is if you assume 0.43 pF steps. Assuming 0.5 pF steps
> >> leads to 25000. Now I am more confused than before.
> >
> > I agree.  It would be nice to get some clarification from Renesas.
>
> Definitely. Do you have access to some support from them?

Luca,

We reached out to  Renesas with the following questions:

1)
I'm seeing a discrepancy between the datasheet and programming guide
we have for the Versaclock 6e in regard to the crystal load
programming registers.  The datasheet for the 5P49V6965A000NLGI
indicates a 9pF minimum with 0.5pF steps, while the programming guide
says that the lower two register bits both add 0.43pF, which would
make the equation:

Ci =3D 9pF + 0.43pF * XTAL[5:1] instead of
Ci =3D 9pF + 0.5pF * XTAL[5:0] as is published in the datasheet.

2)  The programming guide shows that the default setting is 01b, but
the note says it's reserved, use D1 D0 =3D 00.  Can you confirm that we
should set switch mode to 00 instead of the default 01?

And we got the following answers:

1)
     The first one with 0.43pF steps is the correct one. Ci =3D 9pF +
0.43pF * XTAL[5:1]
     0.5pF steps was the design target.  When measuring actual
silicon, we found 0.43pF steps.

     There are 6 bits reserved for the CL setting but bits 0 and 1
have the same 0.43pF step.  So it is actually 5 bits with an extra LSB
of 0.43pF.

2)
      Please use D1 D0 =3D 01.   The =E2=80=9C00=E2=80=9D is a typo=E2=80=
=A6..

Based on the above response I think we should always assume XTAL bit 0
is 0, and only use XTAL[5:1] which should make the math go easier,
because the desired value in femtofarads would just be offset by 9000
and divided by 430 and that value would be shifted 3 places instead fo
two, and the  fixed-point math calculation can go away.

In addition to that, I would also need to make sure that D0 is set to
1, so instead of just writing the shifted XTAL value, I would also
have to do a logic OR with 1 to set the low bit.

I talked with the hardware guys from work who also suggested that we
always write the same value to X1 and X2, so I can remove the X1 and
X2 references from the bindings.

Does that work for you?


adam
> I don't think I have, but I can ask next week.
>
> Regards.
> --
> Luca
