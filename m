Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A12DB22B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgLORFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgLORFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:05:16 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD658C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:04:35 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d203so2910133oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDgJXstgKF9j7SMDsPo/saDYaaI1t27Y21z2DtHCT0c=;
        b=LkCuDyJBRxGjkpZrgFEi72lyz7qRMZfMzeFLaR/+04a8Ktk0stq7gwd+1HwV5QkUam
         G84tJ7NCPoURcZ0M3dD+evQuDtZfTrV5V8bGqtssEA42aF5sq/QgOk4/50Lv1ISTyrgh
         cPimpTNwQsjJrl7aucjM2WZX4rfPbUGjyD2aajuu22XsnaqC1VZiklZupdgbV5rr8yaj
         0fLHoOB9eTQMcWZ2LiwrFSJMTHQaIAsyeB1zeiJPJMgc1yE2nJN+0t8RzRUrMWqbyiOI
         KtLCOIsEtAwem65Qq4qvDKBgYiAqpx5znAfvZLYzpBT2RdSODw06XKRWghAX1T2pZKyd
         csrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDgJXstgKF9j7SMDsPo/saDYaaI1t27Y21z2DtHCT0c=;
        b=S9ed+HPyPM+9tX+Sy58IrtSdC+8Xw6b+IsHfQZAWoSHucSlv6WNRmz/KIuE9rkv+Hm
         m+5HYLzH3IIiQ+mYkXx7BhO83P1tz3FIy17QeERUBzz7/PAnpU5gfsRxowQlUfkMvDxb
         gXK3lQUfLOw2EXm2+GVLvVMMlb8O3fToHDt+NaO+p1W0FkvEYYpAC8Z0aG7d3noPhSwc
         6RxCwusDi+ZNxxivKD9rT5YAoh4UHLoGvyuXoPyMiP18haou0OY6lni4uJAQpkcvbznx
         Hp41MpTQVxPo5fsXogbx9h4V7QHmWgzjBiuFbqoc7iFEleBVINMaEljPIN20rA3WXxF3
         5cFA==
X-Gm-Message-State: AOAM531w/fMU2p1l8jf2pfmeHFaJap8V3X+jRaxPAabLX32Pvwy8Mb//
        +99gMc3a859sxNjl4dp0tAHWhGOdT2ReKUPik9A=
X-Google-Smtp-Source: ABdhPJx57NGD2HnY/fwfeGpjbEvbMQ/blfXMIodPEbmmxGGdLyNfONyVtmnTh/y+m/pPOGHJBES5tVvq9g3ib/OfVlQ=
X-Received: by 2002:a54:4083:: with SMTP id i3mr21883572oii.120.1608051875164;
 Tue, 15 Dec 2020 09:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20201211155553.GC25974@zn.tnic> <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic> <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com> <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
In-Reply-To: <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Dec 2020 12:04:23 -0500
Message-ID: <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="000000000000cce89105b683c0ff"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cce89105b683c0ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2020 at 11:42 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> On 12/15, Alex Deucher wrote:
> > On Tue, Dec 15, 2020 at 11:07 AM Rodrigo Siqueira
> > <Rodrigo.Siqueira@amd.com> wrote:
> > >
> > > Hi,
> > >
> > > Could you try on Alex's repo?
> > >
> > >  git://people.freedesktop.org/~agd5f/linux
> > >  branch: amd-staging-drm-next
> > >
> > > My patch should apply without any issue on top of this branch.
> >
> > Can you help me identify what patches we need to backport to 5.10?
>
> If we have this patch in 5.10:
>
>  drm/amd/display: disable stream if pixel clock changed with link active
>
> We need to backport:
>
>  1. drm/amd/display: Fix module load hangs when connected to an eDP (for
> DCN)

That is already present:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv5.10&id=3D44264591a8c4da7090a4bfd10e04f4cb8fe60afe

>  2. drm/amd/display: Add get_dig_frontend implementation for DCEx (for
> DCEx - we still need Boris feedback)

That patch trivially backports to 5.10.  See attached backported
patch.  @Borislav Petkov does the attached patch fix 5.10 for you?

Alex


>
>
> > Depending on the patches, it might be easier to just revert this for
> > 5.10 and apply the proper fix for 5.11.
>
> I like this approach; we can apply the proper fix on 5.11.
>
> Thanks
>
> > Alex
> >
> >
> > >
> > > Thanks
> > >
> > > On 12/15, Borislav Petkov wrote:
> > > > On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> > > > > Hi Boris,
> > > > >
> > > > > Could you check if your branch has this commit:
> > > > >
> > > > >  drm/amd/display: Fix module load hangs when connected to an eDP
> > > > >
> > > > > If so, could you try this patch:
> > > > >
> > > > >  https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fpatchwork.freedesktop.org%2Fseries%2F84965%2F&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637436459421073301%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DmcdJ1E3tJc%2FK%2Bnf2phU2CFDQ2wp5zrMcRbxdLxQdo3I%3D&amp;reserved=3D0
> > > >
> > > > So I did a bisection between
> > > >
> > > > git bisect start
> > > > # bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> > > > git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> > > > # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> > > >
> > > > and the patch in $Subject came in in 5.10-rc1.
> > > >
> > > > I can test any tree you want me to so just tell me on which tree to
> > > > apply this patch and I'll run it.
> > > >
> > > > In any case, it doesn't apply on v5.10 though:
> > > >
> > > > $ test-apply.sh /tmp/rodrigo.siqueira
> > > > checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > > > Hunk #1 FAILED at 120
> > > >
> > > > You can push a tree of yours somewhere which I can try directly,
> > > > alternatively.
> > > >
> > > > Lemme know.
> > > >
> > > > Thx.
> > > >
> > > > --
> > > > Regards/Gruss,
> > > >     Boris.
> > > >
> > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRod=
rigo.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637436459421073301%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DbHJQuQqFRTA2SU6Va9gt4lvnogZUeYRujeQj4fIXBsE%3D&amp;reserved=3D0
> > >
> > > --
> > > Rodrigo Siqueira
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs=
iqueira.tech%2F&amp;data=3D04%7C01%7CRodrigo.Siqueira%40amd.com%7C3b8b84a38=
15d4a3cc67e08d8a1152189%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637436=
459421073301%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DbZvusCFfCrWSitpFa%2BmWyg%2B=
AbJ04ybnlUMQiEB3m5OY%3D&amp;reserved=3D0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRo=
drigo.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637436459421083297%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3D3K1EuoePhkVVVT7JvPUeKuJW5RIGiHC9LNoqI9ZiTHc%3D&amp;reserved=3D0
>
> --
> Rodrigo Siqueira
> https://siqueira.tech

--000000000000cce89105b683c0ff
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amd-display-Add-get_dig_frontend-implementation-.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-Add-get_dig_frontend-implementation-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kiq8gt8n0>
X-Attachment-Id: f_kiq8gt8n0

RnJvbSA5NjU0MjEwOTY3NzBiYjBkNjk0NDQ5NTBjMWY4MzllOGU1NTA0ZGE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFt
ZC5jb20+CkRhdGU6IFR1ZSwgMTUgRGVjIDIwMjAgMTA6NDU6MDUgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBnZXRfZGlnX2Zyb250ZW5kIGltcGxlbWVudGF0aW9u
IGZvciBEQ0V4CgpTb21lIG9sZCBBU0lDcyBtaWdodCBub3QgaW1wbGVtZW50L3JlcXVpcmUgZ2V0
X2RpZ19mcm9udGVuZCBoZWxwZXI7IGluCnRoaXMgc2NlbmFyaW8sIHdlIGNhbiBoYXZlIGEgTlVM
TCBwb2ludGVyIGV4Y2VwdGlvbiB3aGVuIHdlIHRyeSB0byBjYWxsCml0IGluc2lkZSB2YmlvcyBk
aXNhYmxlIG9wZXJhdGlvbi4gRm9yIGV4YW1wbGUsIHRoaXMgc2l0dWF0aW9uIG1pZ2h0CmhhcHBl
biB3aGVuIHVzaW5nIFBvbGFyaXMxMiB3aXRoIGFuIGVEUCBwYW5lbC4gVGhpcyBjb21taXQgYXZv
aWRzIHRoaXMKc2l0dWF0aW9uIGJ5IGFkZGluZyBhIHNwZWNpZmljIGdldF9kaWdfZnJvbnRlbmQg
aW1wbGVtZW50YXRpb24gZm9yIERDRXguCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+CkNjOiBIYXJy
eSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KQ2M6IE5pY2hvbGFzIEthemxhdXNr
YXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4KQ2M6IENoaWF3ZW4gSHVhbmcgPGNoaWF3
ZW4uaHVhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmln
by5TaXF1ZWlyYUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2xp
bmtfZW5jb2Rlci5jIHwgNDUgKysrKysrKysrKysrKysrKysrLQogLi4uL2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5oIHwgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA0NSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMKaW5kZXggYjQwOWY2YjJiZmQ4
Li5mMzU1Y2QxZTkwOTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jCkBAIC0xMTksNyArMTE5LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBsaW5rX2VuY29kZXJfZnVuY3MgZGNlMTEwX2xua19lbmNfZnVuY3MgPSB7CiAJ
LmRpc2FibGVfaHBkID0gZGNlMTEwX2xpbmtfZW5jb2Rlcl9kaXNhYmxlX2hwZCwKIAkuaXNfZGln
X2VuYWJsZWQgPSBkY2UxMTBfaXNfZGlnX2VuYWJsZWQsCiAJLmRlc3Ryb3kgPSBkY2UxMTBfbGlu
a19lbmNvZGVyX2Rlc3Ryb3ksCi0JLmdldF9tYXhfbGlua19jYXAgPSBkY2UxMTBfbGlua19lbmNv
ZGVyX2dldF9tYXhfbGlua19jYXAKKwkuZ2V0X21heF9saW5rX2NhcCA9IGRjZTExMF9saW5rX2Vu
Y29kZXJfZ2V0X21heF9saW5rX2NhcCwKKwkuZ2V0X2RpZ19mcm9udGVuZCA9IGRjZTExMF9nZXRf
ZGlnX2Zyb250ZW5kLAogfTsKIAogc3RhdGljIGVudW0gYnBfcmVzdWx0IGxpbmtfdHJhbnNtaXR0
ZXJfY29udHJvbCgKQEAgLTIzNSw2ICsyMzYsNDUgQEAgc3RhdGljIHZvaWQgc2V0X2xpbmtfdHJh
aW5pbmdfY29tcGxldGUoCiAKIH0KIAordW5zaWduZWQgaW50IGRjZTExMF9nZXRfZGlnX2Zyb250
ZW5kKHN0cnVjdCBsaW5rX2VuY29kZXIgKmVuYykKK3sKKwlzdHJ1Y3QgZGNlMTEwX2xpbmtfZW5j
b2RlciAqZW5jMTEwID0gVE9fRENFMTEwX0xJTktfRU5DKGVuYyk7CisJdTMyIHZhbHVlOworCWVu
dW0gZW5naW5lX2lkIHJlc3VsdDsKKworCVJFR19HRVQoRElHX0JFX0NOVEwsIERJR19GRV9TT1VS
Q0VfU0VMRUNULCAmdmFsdWUpOworCisJc3dpdGNoICh2YWx1ZSkgeworCWNhc2UgRENFMTEwX0RJ
R19GRV9TT1VSQ0VfU0VMRUNUX0RJR0E6CisJCXJlc3VsdCA9IEVOR0lORV9JRF9ESUdBOworCQli
cmVhazsKKwljYXNlIERDRTExMF9ESUdfRkVfU09VUkNFX1NFTEVDVF9ESUdCOgorCQlyZXN1bHQg
PSBFTkdJTkVfSURfRElHQjsKKwkJYnJlYWs7CisJY2FzZSBEQ0UxMTBfRElHX0ZFX1NPVVJDRV9T
RUxFQ1RfRElHQzoKKwkJcmVzdWx0ID0gRU5HSU5FX0lEX0RJR0M7CisJCWJyZWFrOworCWNhc2Ug
RENFMTEwX0RJR19GRV9TT1VSQ0VfU0VMRUNUX0RJR0Q6CisJCXJlc3VsdCA9IEVOR0lORV9JRF9E
SUdEOworCQlicmVhazsKKwljYXNlIERDRTExMF9ESUdfRkVfU09VUkNFX1NFTEVDVF9ESUdFOgor
CQlyZXN1bHQgPSBFTkdJTkVfSURfRElHRTsKKwkJYnJlYWs7CisJY2FzZSBEQ0UxMTBfRElHX0ZF
X1NPVVJDRV9TRUxFQ1RfRElHRjoKKwkJcmVzdWx0ID0gRU5HSU5FX0lEX0RJR0Y7CisJCWJyZWFr
OworCWNhc2UgRENFMTEwX0RJR19GRV9TT1VSQ0VfU0VMRUNUX0RJR0c6CisJCXJlc3VsdCA9IEVO
R0lORV9JRF9ESUdHOworCQlicmVhazsKKwlkZWZhdWx0OgorCQkvLyBpbnZhbGlkIHNvdXJjZSBz
ZWxlY3QgRElHCisJCUFTU0VSVChmYWxzZSk7CisJCXJlc3VsdCA9IEVOR0lORV9JRF9VTktOT1dO
OworCX0KKworCXJldHVybiByZXN1bHQ7Cit9CisKIHZvaWQgZGNlMTEwX2xpbmtfZW5jb2Rlcl9z
ZXRfZHBfcGh5X3BhdHRlcm5fdHJhaW5pbmdfcGF0dGVybigKIAlzdHJ1Y3QgbGlua19lbmNvZGVy
ICplbmMsCiAJdWludDMyX3QgaW5kZXgpCkBAIC0xNjY1LDcgKzE3MDUsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGxpbmtfZW5jb2Rlcl9mdW5jcyBkY2U2MF9sbmtfZW5jX2Z1bmNzID0gewogCS5k
aXNhYmxlX2hwZCA9IGRjZTExMF9saW5rX2VuY29kZXJfZGlzYWJsZV9ocGQsCiAJLmlzX2RpZ19l
bmFibGVkID0gZGNlMTEwX2lzX2RpZ19lbmFibGVkLAogCS5kZXN0cm95ID0gZGNlMTEwX2xpbmtf
ZW5jb2Rlcl9kZXN0cm95LAotCS5nZXRfbWF4X2xpbmtfY2FwID0gZGNlMTEwX2xpbmtfZW5jb2Rl
cl9nZXRfbWF4X2xpbmtfY2FwCisJLmdldF9tYXhfbGlua19jYXAgPSBkY2UxMTBfbGlua19lbmNv
ZGVyX2dldF9tYXhfbGlua19jYXAsCisJLmdldF9kaWdfZnJvbnRlbmQgPSBkY2UxMTBfZ2V0X2Rp
Z19mcm9udGVuZAogfTsKIAogdm9pZCBkY2U2MF9saW5rX2VuY29kZXJfY29uc3RydWN0KApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNv
ZGVyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9saW5rX2VuY29k
ZXIuaAppbmRleCBjYjcxNGE0OGIxNzEuLmZjNmFkZTgyNGMyMyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmgKQEAgLTI5
NSw2ICsyOTUsOCBAQCB2b2lkIGRjZTExMF9saW5rX2VuY29kZXJfY29ubmVjdF9kaWdfYmVfdG9f
ZmUoCiAJZW51bSBlbmdpbmVfaWQgZW5naW5lLAogCWJvb2wgY29ubmVjdCk7CiAKK3Vuc2lnbmVk
IGludCBkY2UxMTBfZ2V0X2RpZ19mcm9udGVuZChzdHJ1Y3QgbGlua19lbmNvZGVyICplbmMpOwor
CiB2b2lkIGRjZTExMF9saW5rX2VuY29kZXJfc2V0X2RwX3BoeV9wYXR0ZXJuX3RyYWluaW5nX3Bh
dHRlcm4oCiAJc3RydWN0IGxpbmtfZW5jb2RlciAqZW5jLAogCXVpbnQzMl90IGluZGV4KTsKLS0g
CjIuMjUuNAoK
--000000000000cce89105b683c0ff--
