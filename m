Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD92FCA19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbhATEu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbhATEpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:45:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A859C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:45:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h205so32334328lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQnZg6nYQ604S+C87nenYZxJgyrJCpgvQPnr5QCbDno=;
        b=XZ4qtF8xZ5d9qSwwXbM1BnjVs5CxJ23B6RiPky/qMZKn0M7haSSQ6E8PlEwfu7zHy/
         oO3aEAbHi/EDvXmq46VetVFEUHvt2SIToYPJZI+9UAXv2eLhKTbiUCM6458PPEYVy46p
         UcowJC2jP3rbhRZqkq1TgCNe9uk1bkKoHZDlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQnZg6nYQ604S+C87nenYZxJgyrJCpgvQPnr5QCbDno=;
        b=PIMG2+5qvPVHoy4SYWrZPV9+zSiztexcFehxAsYfiYwe/Ohq2I+sybduVPyD/dQgaU
         IL6vbgxKVdLvjy1GXcn6mr9vI30BlXkLhUqYJQHvdGaxW9nscQ3lG8MAZX+gBEemowCG
         oTt69j+H0+vXZ2n9mIgB3mokQlamvRuchStjuZTrs6X3ce2q+MOxvbQCxsEwT/cu4MIa
         Q1uLJaSjwcI0mQ533OULUxHtu7OZlgWPiqkJcNvOE/dZDQJPQPTkyhtmyHyKaTTyfUbX
         0LdoYjx8iD74/dsUWJnHp3lbYe1LboSQOM1aRkfPA3fhiuU5jxNeUVoAIpM318rpK4YD
         n9cA==
X-Gm-Message-State: AOAM533Inod7RNv/WEQ3OQr7apmsuLkDiq089EaEXsulL1rtfIBxAFC7
        bv2b1z69EmavRtycJWhvX68zN0VzFRZpXg==
X-Google-Smtp-Source: ABdhPJw3Ig8dAV2F2kuUoTJRr1xly2P1ngEQUI9g/w+iV2xoj78W5yn52kwbDp01hqdbZK3rfmB9cA==
X-Received: by 2002:a05:6512:32ad:: with SMTP id q13mr3140583lfe.83.1611117909278;
        Tue, 19 Jan 2021 20:45:09 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f4sm86908lfd.198.2021.01.19.20.45.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 20:45:07 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 3so4333134ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:45:07 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr3252632lji.48.1611117906844;
 Tue, 19 Jan 2021 20:45:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
In-Reply-To: <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jan 2021 20:44:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
Message-ID: <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008803ad05b94d9e69"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008803ad05b94d9e69
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 19, 2021 at 5:29 PM Oliver Giles <ohw.giles@gmail.com> wrote:
>
> Writing this from a kernel with those patches in; happily splice()ing
> to and from a pty.

Ok, good.

I have a couple of improvement patches on top of those, that I'm attaching here.

The first four patches worked fine for me (and apparently for you
too), but due to the small buffer, the regular N_TTY case for tty
read() calls are now limited to 64 bytes each.

That is unfortunate for performance, but it might also cause some
actual breakage: anybody doing "read()" calls on a tty file descriptor
_should_ be perfectly fine with short reads since they happen for
signals etc, but I could well imagine that not everybody is.

And that new kernel buffer interface was _designed_ to allow stitching
small buffers together efficiently (since the hdlc case needed it), so
this implements that for the non-icanon case for n_tty too.

I wasted an embarrasing amount of time today on that final patch - I
spent something like 6 hours chasing a truly stupid one-liner bug I
had initially, and couldn't see what was wrong.

Which is why this only does the non-icanon case, because after I
finally had my "Duh!" moment, I was so annoyed with it that I had to
just walk away.

I'll come back to this tomorrow and do the line-buffered icanon case
too (unless pull requests pile up), and then I'll be happy with the
tty changes, and I think I can submit this series for real to Greg.

But in the meantime, here's two more patches to try on top of the
previous four. They shouldn't matter, other than making the non-icanon
throughput a lot better. But the more coverage they get, the happier
I'll be.

           Linus

--0000000000008803ad05b94d9e69
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0005-tty-clean-up-legacy-leftovers-from-n_tty-line-discip.patch"
Content-Disposition: attachment; 
	filename="0005-tty-clean-up-legacy-leftovers-from-n_tty-line-discip.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kk4xx0n00>
X-Attachment-Id: f_kk4xx0n00

RnJvbSBiMTJhMTY1MmM5MTY0OGU5NmFlMTE5NDZmNzQ4OTUxNWRkMDYzNzg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTkgSmFuIDIwMjEgMTM6NDY6MjggLTA4MDAKU3ViamVjdDog
W1BBVENIIDUvNl0gdHR5OiBjbGVhbiB1cCBsZWdhY3kgbGVmdG92ZXJzIGZyb20gbl90dHkgbGlu
ZSBkaXNjaXBsaW5lCgpCYWNrIHdoZW4gdGhlIGxpbmUgZGlzY2lwbGluZXMgZGlkIHRoZWlyIG93
biBkaXJlY3QgdXNlciBhY2Nlc3NlcywgdGhleQpoYWQgdG8gZGVhbCB3aXRoIHRoZSBkYXRhIGNv
cHkgcG9zc2libHkgZmFpbGluZyBpbiB0aGUgbWlkZGxlLgoKTm93IHRoYXQgdGhlIHVzZXIgY29w
eSBpcyBkb25lIGJ5IHRoZSB0dHlfaW8uYyBjb2RlLCB0aGF0IGZhaWx1cmUgY2FzZQpubyBsb25n
ZXIgZXhpc3RzLgoKUmVtb3ZlIHRoZSBsZWZ0LW92ZXIgZXJyb3IgaGFuZGxpbmcgY29kZSB0aGF0
IGNhbm5vdCB0cmlnZ2VyLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvdHR5L25fdHR5LmMgfCAxNiArKysr
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9uX3R0eS5jIGIvZHJpdmVycy90dHkvbl90
dHkuYwppbmRleCAyZjJmNTdhNTM5NjguLmEwMmZlNjYxZjYxNyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90dHkvbl90dHkuYworKysgYi9kcml2ZXJzL3R0eS9uX3R0eS5jCkBAIC0xOTU3LDE5ICsxOTU3
LDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGlucHV0X2F2YWlsYWJsZV9wKHN0cnVjdCB0dHlfc3Ry
dWN0ICp0dHksIGludCBwb2xsKQogICoJCXJlYWRfdGFpbCBwdWJsaXNoZWQKICAqLwogCi1zdGF0
aWMgaW50IGNvcHlfZnJvbV9yZWFkX2J1ZihzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LAorc3RhdGlj
IHZvaWQgY29weV9mcm9tX3JlYWRfYnVmKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksCiAJCQkJICAg
ICAgdW5zaWduZWQgY2hhciAqKmticCwKIAkJCQkgICAgICBzaXplX3QgKm5yKQogCiB7CiAJc3Ry
dWN0IG5fdHR5X2RhdGEgKmxkYXRhID0gdHR5LT5kaXNjX2RhdGE7Ci0JaW50IHJldHZhbDsKIAlz
aXplX3QgbjsKIAlib29sIGlzX2VvZjsKIAlzaXplX3QgaGVhZCA9IHNtcF9sb2FkX2FjcXVpcmUo
JmxkYXRhLT5jb21taXRfaGVhZCk7CiAJc2l6ZV90IHRhaWwgPSBsZGF0YS0+cmVhZF90YWlsICYg
KE5fVFRZX0JVRl9TSVpFIC0gMSk7CiAKLQlyZXR2YWwgPSAwOwogCW4gPSBtaW4oaGVhZCAtIGxk
YXRhLT5yZWFkX3RhaWwsIE5fVFRZX0JVRl9TSVpFIC0gdGFpbCk7CiAJbiA9IG1pbigqbnIsIG4p
OwogCWlmIChuKSB7CkBAIC0xOTg2LDcgKzE5ODQsNiBAQCBzdGF0aWMgaW50IGNvcHlfZnJvbV9y
ZWFkX2J1ZihzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LAogCQkqa2JwICs9IG47CiAJCSpuciAtPSBu
OwogCX0KLQlyZXR1cm4gcmV0dmFsOwogfQogCiAvKioKQEAgLTIyMjgsMjAgKzIyMjUsMTUgQEAg
c3RhdGljIHNzaXplX3Qgbl90dHlfcmVhZChzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3Qg
ZmlsZSAqZmlsZSwKIAkJCWlmIChyZXR2YWwpCiAJCQkJYnJlYWs7CiAJCX0gZWxzZSB7Ci0JCQlp
bnQgdW5jb3BpZWQ7Ci0KIAkJCS8qIERlYWwgd2l0aCBwYWNrZXQgbW9kZS4gKi8KIAkJCWlmIChw
YWNrZXQgJiYga2IgPT0ga2J1ZikgewogCQkJCSprYisrID0gVElPQ1BLVF9EQVRBOwogCQkJCW5y
LS07CiAJCQl9CiAKLQkJCXVuY29waWVkID0gY29weV9mcm9tX3JlYWRfYnVmKHR0eSwgJmtiLCAm
bnIpOwotCQkJdW5jb3BpZWQgKz0gY29weV9mcm9tX3JlYWRfYnVmKHR0eSwgJmtiLCAmbnIpOwot
CQkJaWYgKHVuY29waWVkKSB7Ci0JCQkJcmV0dmFsID0gLUVGQVVMVDsKLQkJCQlicmVhazsKLQkJ
CX0KKwkJCS8qIFNlZSBjb21tZW50IGFib3ZlIGNvcHlfZnJvbV9yZWFkX2J1ZigpIHdoeSB0d2lj
ZSAqLworCQkJY29weV9mcm9tX3JlYWRfYnVmKHR0eSwgJmtiLCAmbnIpOworCQkJY29weV9mcm9t
X3JlYWRfYnVmKHR0eSwgJmtiLCAmbnIpOwogCQl9CiAKIAkJbl90dHlfY2hlY2tfdW50aHJvdHRs
ZSh0dHkpOwotLSAKMi4yOS4yLjE1Ny5nMWQ0Nzc5MWEzOQoK
--0000000000008803ad05b94d9e69
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0006-tty-teach-n_tty-line-discipline-about-the-new-cookie.patch"
Content-Disposition: attachment; 
	filename="0006-tty-teach-n_tty-line-discipline-about-the-new-cookie.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kk4xx4701>
X-Attachment-Id: f_kk4xx4701

RnJvbSBlNzI0Y2M5YzRiMTAxYTRkZTFhNTZiY2NhNmI1ZWMxZDM0OTNiMTczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTkgSmFuIDIwMjEgMTg6MTQ6MjAgLTA4MDAKU3ViamVjdDog
W1BBVENIIDYvNl0gdHR5OiB0ZWFjaCBuX3R0eSBsaW5lIGRpc2NpcGxpbmUgYWJvdXQgdGhlIG5l
dyAiY29va2llCiBjb250aW51YXRpb25zIgoKV2l0aCB0aGUgY29udmVyc2lvbiB0byBkbyB0aGUg
dHR5IGxkaXNjIHJlYWQgb3BlcmF0aW9ucyBpbiBzbWFsbCBjaHVua3MsCnRoZSBuX3R0eSBsaW5l
IGRpc2NpcGxpbmUgYmVjYW1lIG5vdGljZWFibHkgc2xvd2VyIGZvciB0aHJvdWdocHV0Cm9yaWVu
dGVkIGxvYWRzLCBiZWNhdXNlIHJhdGhlciB0aGFuIHJlYWQgdGhpbmdzIGluIHVwIHRvIDJrQiBj
aHVua3MsIGl0CndvdWxkIHJldHVybiBhdCBtb3N0IDY0IGJ5dGVzIHBlciByZWFkKCkgc3lzdGVt
IGNhbGwuCgpUaGUgY29zdCBpcyBtYWlubHkgYWxsIGluIHRoZSAiZG8gc3lzdGVtIGNhbGxzIG92
ZXIgYW5kIG92ZXIiLCBub3QKcmVhbGx5IGluIHRoZSBuZXcgImNvcHkgdG8gYW4gZXh0cmEga2Vy
bmVsIGJ1ZmZlciIuCgpUaGlzIGNhbiBiZSBmaXhlZCBieSB0ZWFjaGluZyB0aGUgbl90dHkgbGlu
ZSBkaXNjaXBsaW5lIGFib3V0IHRoZQoiY29va2llIGNvbnRpbnVhdGlvbiIgbW9kZWwsIHdoaWNo
IHRoZSBjaHVua2luZyBjb2RlIHN1cHBvcnRzIGJlY2F1c2UKdGhpbmdzIGxpa2UgaGRsYyBuZWVk
IHRvIGJlIGFibGUgdG8gaGFuZGxlIHBhY2tldHMgdXAgdG8gNjRrQiBpbiBzaXplLgoKRG9pbmcg
dGhhdCBkb2Vzbid0IGp1c3QgZ2V0IHVzIGJhY2sgdG8gdGhlIG9sZCBwZXJmb3JtYWNlLCBidXQg
dG8gbXVjaApiZXR0ZXIgcGVyZm9ybWFuY2U6IG15IHN0dXBpZCAiY29weSAxME1CIG9mIGRhdGEg
b3ZlciBhIHB0eSIgdGVzdApwcm9ncmFtIGlzIG5vdyBhbG1vc3QgdHdpY2UgYXMgZmFzdCBhcyBp
dCB1c2VkIHRvIGJlIChnb2luZyBkb3duIGZyb20KMC4xcyB0byAwLjA1NHMpLgoKVGhpcyBpcyBl
bnRpcmVseSBiZWNhdXNlIGl0IG5vdyBjcmVhdGVzIG1heGltYWwgY2h1bmtzICh3aGljaCBoYXBw
ZW5zIHRvCmJlICJvbmUgYnl0ZSBsZXNzIHRoYW4gb25lIHBhZ2UiIGR1ZSB0byBob3cgd2UgZG8g
dGhlIGNpcmN1bGFyIHR0eQpidWZmZXJzKS4KCk5PVEUhIFRoaXMgY2FzZSBvbmx5IGhhbmRsZXMg
dGhlIHNpbXBsZXIgbm9uLWljYW5vbiBjYXNlLCB3aGljaCBpcyB0aGUKb25lIHdoZXJlIHBlb3Bs
ZSBtYXkgY2FyZSBhYm91dCB0aHJvdWdocHV0LiAgSSdtIGdvaW5nIHRvIGRvIHRoZSBpY2Fub24K
Y2FzZSBsYXRlciB0b28sIGJlY2F1c2Ugd2hpbGUgcGVyZm9ybWFuY2UgaXNuJ3QgYSBtYWpvciBp
c3N1ZSBmb3IgdGhhdCwKdGhlcmUgbWF5IGJlIHByb2dyYW1zIHRoYXQgdGhpbmsgdGhleSdsbCBh
bHdheXMgZ2V0IGEgZnVsbCBsaW5lIGFuZApkb24ndCBsaWtlIHRoZSA2NC1ieXRlIGNodW5raW5n
IGZvciB0aGF0IHJlYXNvbi4KClN1Y2ggcHJvZ3JhbXMgYXJlIGFyZ3VhYmx5IGJ1Z2d5IChzaWdu
YWxzIGV0YyBjYW4gY2F1c2UgcmFuZG9tIHBhcnRpYWwKcmVzdWx0cyBmcm9tIHR0eSByZWFkcyBh
bnl3YXkpLCBhbmQgZ29vZCBwcm9ncmFtcyB3aWxsIGhhbmRsZSBzdWNoCnBhcnRpYWwgcmVhZHMs
IGJ1dCBleHBlY3RpbmcgZXZlcnlib2R5IHRvIHdyaXRlICJnb29kIHByb2dyYW1zIiBoYXMKbmV2
ZXIgYmVlbiBhIHdpbm5pbmcgcG9saWN5IGZvciB0aGUga2VybmVsLi4KClNpZ25lZC1vZmYtYnk6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2
ZXJzL3R0eS9uX3R0eS5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvbl90dHkuYyBiL2RyaXZlcnMvdHR5L25fdHR5
LmMKaW5kZXggYTAyZmU2NjFmNjE3Li4zN2JmZDY5NTAxMWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dHR5L25fdHR5LmMKKysrIGIvZHJpdmVycy90dHkvbl90dHkuYwpAQCAtMTk0NSwxOSArMTk0NSwx
NyBAQCBzdGF0aWMgaW5saW5lIGludCBpbnB1dF9hdmFpbGFibGVfcChzdHJ1Y3QgdHR5X3N0cnVj
dCAqdHR5LCBpbnQgcG9sbCkKICAqCUhlbHBlciBmdW5jdGlvbiB0byBzcGVlZCB1cCBuX3R0eV9y
ZWFkLiAgSXQgaXMgb25seSBjYWxsZWQgd2hlbgogICoJSUNBTk9OIGlzIG9mZjsgaXQgY29waWVz
IGNoYXJhY3RlcnMgc3RyYWlnaHQgZnJvbSB0aGUgdHR5IHF1ZXVlLgogICoKLSAqCUl0IGNhbiBi
ZSBwcm9maXRhYmx5IGNhbGxlZCB0d2ljZTsgb25jZSB0byBkcmFpbiB0aGUgc3BhY2UgZnJvbQot
ICoJdGhlIHRhaWwgcG9pbnRlciB0byB0aGUgKHBoeXNpY2FsKSBlbmQgb2YgdGhlIGJ1ZmZlciwg
YW5kIG9uY2UKLSAqCXRvIGRyYWluIHRoZSBzcGFjZSBmcm9tIHRoZSAocGh5c2ljYWwpIGJlZ2lu
bmluZyBvZiB0aGUgYnVmZmVyCi0gKgl0byBoZWFkIHBvaW50ZXIuCi0gKgogICoJQ2FsbGVkIHVu
ZGVyIHRoZSBsZGF0YS0+YXRvbWljX3JlYWRfbG9jayBzZW0KICAqCisgKglSZXR1cm5zIHRydWUg
aWYgaXQgc3VjY2Vzc2Z1bGx5IGNvcGllZCBkYXRhLCBidXQgdGhlcmUgaXMgc3RpbGwKKyAqCW1v
cmUgZGF0YSB0byBiZSBoYWQuCisgKgogICoJbl90dHlfcmVhZCgpL2NvbnN1bWVyIHBhdGg6CiAg
KgkJY2FsbGVyIGhvbGRzIG5vbi1leGNsdXNpdmUgdGVybWlvc19yd3NlbQogICoJCXJlYWRfdGFp
bCBwdWJsaXNoZWQKICAqLwogCi1zdGF0aWMgdm9pZCBjb3B5X2Zyb21fcmVhZF9idWYoc3RydWN0
IHR0eV9zdHJ1Y3QgKnR0eSwKK3N0YXRpYyBib29sIGNvcHlfZnJvbV9yZWFkX2J1ZihzdHJ1Y3Qg
dHR5X3N0cnVjdCAqdHR5LAogCQkJCSAgICAgIHVuc2lnbmVkIGNoYXIgKiprYnAsCiAJCQkJICAg
ICAgc2l6ZV90ICpucikKIApAQCAtMTk4MCwxMCArMTk3OCwxNCBAQCBzdGF0aWMgdm9pZCBjb3B5
X2Zyb21fcmVhZF9idWYoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwKIAkJLyogVHVybiBzaW5nbGUg
RU9GIGludG8gemVyby1sZW5ndGggcmVhZCAqLwogCQlpZiAoTF9FWFRQUk9DKHR0eSkgJiYgbGRh
dGEtPmljYW5vbiAmJiBpc19lb2YgJiYKIAkJICAgIChoZWFkID09IGxkYXRhLT5yZWFkX3RhaWwp
KQotCQkJbiA9IDA7CisJCQlyZXR1cm4gZmFsc2U7CiAJCSprYnAgKz0gbjsKIAkJKm5yIC09IG47
CisKKwkJLyogSWYgd2UgaGF2ZSBtb3JlIHRvIGNvcHksIGxldCB0aGUgY2FsbGVyIGtub3cgKi8K
KwkJcmV0dXJuIGhlYWQgIT0gbGRhdGEtPnJlYWRfdGFpbDsKIAl9CisJcmV0dXJuIGZhbHNlOwog
fQogCiAvKioKQEAgLTIxMzUsNiArMjEzNywyNSBAQCBzdGF0aWMgc3NpemVfdCBuX3R0eV9yZWFk
KHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCBmaWxlICpmaWxlLAogCWludCBwYWNrZXQ7
CiAJc2l6ZV90IHRhaWw7CiAKKwkvKgorCSAqIElzIHRoaXMgYSBjb250aW51YXRpb24gb2YgYSBy
ZWFkIHN0YXJ0ZWQgZWFybGVyPworCSAqCisJICogSWYgc28sIHdlIHN0aWxsIGhvbGQgdGhlIGF0
b21pY19yZWFkX2xvY2sgYW5kIHRoZQorCSAqIHRlcm1pb3NfcndzZW0sIGFuZCBjYW4ganVzdCBj
b250aW51ZSB0byBjb3B5IGRhdGEuCisJICovCisJaWYgKCpjb29raWUpIHsKKwkJaWYgKGNvcHlf
ZnJvbV9yZWFkX2J1Zih0dHksICZrYiwgJm5yKSkKKwkJCXJldHVybiBrYiAtIGtidWY7CisKKwkJ
LyogTm8gbW9yZSBkYXRhIC0gcmVsZWFzZSBsb2NrcyBhbmQgc3RvcCByZXRyaWVzICovCisJCW5f
dHR5X2tpY2tfd29ya2VyKHR0eSk7CisJCW5fdHR5X2NoZWNrX3VudGhyb3R0bGUodHR5KTsKKwkJ
dXBfcmVhZCgmdHR5LT50ZXJtaW9zX3J3c2VtKTsKKwkJbXV0ZXhfdW5sb2NrKCZsZGF0YS0+YXRv
bWljX3JlYWRfbG9jayk7CisJCSpjb29raWUgPSBOVUxMOworCQlyZXR1cm4ga2IgLSBrYnVmOwor
CX0KKwogCWMgPSBqb2JfY29udHJvbCh0dHksIGZpbGUpOwogCWlmIChjIDwgMCkKIAkJcmV0dXJu
IGM7CkBAIC0yMjMxLDkgKzIyNTIsMjAgQEAgc3RhdGljIHNzaXplX3Qgbl90dHlfcmVhZChzdHJ1
Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJCQluci0tOwogCQkJfQog
Ci0JCQkvKiBTZWUgY29tbWVudCBhYm92ZSBjb3B5X2Zyb21fcmVhZF9idWYoKSB3aHkgdHdpY2Ug
Ki8KLQkJCWNvcHlfZnJvbV9yZWFkX2J1Zih0dHksICZrYiwgJm5yKTsKLQkJCWNvcHlfZnJvbV9y
ZWFkX2J1Zih0dHksICZrYiwgJm5yKTsKKwkJCS8qCisJCQkgKiBDb3B5IGRhdGEsIGFuZCBpZiB0
aGVyZSBpcyBtb3JlIHRvIGJlIGhhZAorCQkJICogYW5kIHdlIGhhdmUgbm90aGluZyBtb3JlIHRv
IHdhaXQgZm9yLCB0aGVuCisJCQkgKiBsZXQncyBtYXJrIHVzIGZvciByZXRyaWVzLgorCQkJICoK
KwkJCSAqIE5PVEUhIFdlIHJldHVybiBoZXJlIHdpdGggYm90aCB0aGUgdGVybWlvc19zZW0KKwkJ
CSAqIGFuZCBhdG9taWNfcmVhZF9sb2NrIHN0aWxsIGhlbGQsIHRoZSByZXRyaWVzCisJCQkgKiB3
aWxsIHJlbGVhc2UgdGhlbSB3aGVuIGRvbmUuCisJCQkgKi8KKwkJCWlmIChjb3B5X2Zyb21fcmVh
ZF9idWYodHR5LCAma2IsICZucikgJiYga2IgLSBrYnVmID49IG1pbmltdW0pIHsKKwkJCQlyZW1v
dmVfd2FpdF9xdWV1ZSgmdHR5LT5yZWFkX3dhaXQsICZ3YWl0KTsKKwkJCQkqY29va2llID0gY29v
a2llOworCQkJCXJldHVybiBrYiAtIGtidWY7CisJCQl9CiAJCX0KIAogCQluX3R0eV9jaGVja191
bnRocm90dGxlKHR0eSk7Ci0tIAoyLjI5LjIuMTU3LmcxZDQ3NzkxYTM5Cgo=
--0000000000008803ad05b94d9e69--
