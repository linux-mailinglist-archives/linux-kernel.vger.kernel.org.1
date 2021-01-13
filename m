Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052AE2F4904
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAMKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAMKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:51:04 -0500
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jan 2021 02:50:07 PST
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:50:06 -0800 (PST)
Received: from [195.4.92.124] (helo=sub5.freenet.de)
        by mout1.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1kzddC-0000pX-BI; Wed, 13 Jan 2021 11:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=01019freenet.de; s=mjaymdexmjqk; h=Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2oj/6SturpqUfIeMqmt924Sm7OfaL7zfbCa+Ey/hRIw=; b=yAuwgwlCGEq2vkILSAaBAs9zP
        nanSIjlG+k/TUpJT68G32SDXO+MrLcfdWe+5QOrQBYZ149zpvIvl/xZV1ywuDbUeBCvL39UB9MpGD
        jKROf60VXa+6fHWg8fJPi74nrbiN61ny6gXVTxhBJWQBVXE67mKSVnTO2RqxXitpLBx7CJNksOoeZ
        aZgg4v9/WZkiQeBbmy/3Qxb6Z0NOrQnthL3mj3JZJBFnPHi0TBVzLtRh2dtX1L41XYgEAZ5K3DgBb
        REboztiaY+eoCpVNfkbLSsqljHF2LqE8ROwyCqaNEYfbDXwzesgRQQhoDDcejW4IQgdJunadQ4D3H
        N1ZgBVtgQ==;
Received: from p200300de573c8400505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:573c:8400:5054:ff:fe15:ac42]:47820 helo=mail.maya.org)
        by sub5.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1kzddC-00082P-88; Wed, 13 Jan 2021 11:44:02 +0100
Received: internal info suppressed
To:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com
Cc:     Borislav Petkov <bp@suse.de>, Harry.Wentland@amd.com,
        Nicholas.Kazlauskas@amd.com, chiawen.huang@amd.com
From:   Andreas Hartmann <andihartmann@01019freenet.de>
Subject: dcn10_get_dig_frontend problem like this fixed in "drm/amd/display:
 Add get_dig_frontend implementation for DCEx"
Message-ID: <e17c2988-d6c0-556e-db41-ddff0d03fe7e@01019freenet.de>
Date:   Wed, 13 Jan 2021 11:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F6FAEED47EC2E8547AE58C1E"
Content-Language: en-US
X-Originated-At: 2003:de:573c:8400:5054:ff:fe15:ac42!47820
X-FNSign: v=2 s=CE36558EB7D8565CC37A04C3B048C64A9802EB5E31311206310757F545CBE919
X-Scan-TS: Wed, 13 Jan 2021 11:44:02 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F6FAEED47EC2E8547AE58C1E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I'm facing probably a similar problem on this machine during resume after s2ram with linux 5.10.7 (see attached file "trace").

The error happens in drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:483 (see ^^^^-line):

unsigned int dcn10_get_dig_frontend(struct link_encoder *enc)
{
	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
	int32_t value;
	enum engine_id result;

	REG_GET(DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, &value);

	switch (value) {
	case DCN10_DIG_FE_SOURCE_SELECT_DIGA:
		result = ENGINE_ID_DIGA;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGB:
		result = ENGINE_ID_DIGB;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGC:
		result = ENGINE_ID_DIGC;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGD:
		result = ENGINE_ID_DIGD;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGE:
		result = ENGINE_ID_DIGE;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGF:
		result = ENGINE_ID_DIGF;
		break;
	case DCN10_DIG_FE_SOURCE_SELECT_DIGG:
		result = ENGINE_ID_DIGG;
		break;
	default:
		// invalid source select DIG
		ASSERT(false);
		result = ENGINE_ID_UNKNOWN;
		^^^^^^^^^^^^^^^^^^^^^^^^^^^
	}

	return result;
}


About the machine:
It's a notebook with two GPUs. AMD is the primary GPU - the secondary GPU (Nvidia) is unused (nouveau is not loaded at all - the proprietary driver isn't even installed)

05:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Picasso (rev c1) (prog-if 00 [VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 18f1
        Flags: bus master, fast devsel, latency 0, IRQ 24
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Memory at f0000000 (64-bit, prefetchable) [size=2M]
        I/O ports at c000 [size=256]
        Memory at f7500000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [64] Express Legacy Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
        Capabilities: [c0] MSI-X: Enable+ Count=3 Masked-
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [200] #15
        Capabilities: [270] #19
        Capabilities: [2a0] Access Control Services
        Capabilities: [2b0] Address Translation Service (ATS)
        Capabilities: [2c0] Page Request Interface (PRI)
        Capabilities: [2d0] Process Address Space ID (PASID)
        Capabilities: [320] Latency Tolerance Reporting
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu

01:00.0 VGA compatible controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Mobile / Max-Q] (rev a1) (prog-if 00 [VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 109f
        Flags: fast devsel, IRQ 255
        Memory at f6000000 (32-bit, non-prefetchable) [disabled] [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [disabled] [size=256M]
        Memory at d0000000 (64-bit, prefetchable) [disabled] [size=32M]
        I/O ports at f000 [disabled] [size=128]
        Expansion ROM at f7000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Capabilities: [250] Latency Tolerance Reporting
        Capabilities: [258] L1 PM Substates
        Capabilities: [128] Power Budgeting <?>
        Capabilities: [420] Advanced Error Reporting
        Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
        Capabilities: [900] #19
        Capabilities: [bb0] #15
        Kernel modules: nouveau

CPU: AMD Ryzen 7 3750H with Radeon Vega Mobile Gfx

Could you please fix this problem, too?
Please CC me for any answer because I'm not regularly reading the kernel mailing list.


Thanks
Andreas Hartmann

--------------F6FAEED47EC2E8547AE58C1E
Content-Type: text/plain; charset=UTF-8;
 name="trace"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="trace"

MjAyMS0wMS0xM1QxMDo1MjowMi4xMzUyMDIrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAg
MTU1LjY0NTE3OF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCjIwMjEt
MDEtMTNUMTA6NTI6MDIuMTM1MjA0KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42
NDUzMzBdIFdBUk5JTkc6IENQVTogNiBQSUQ6IDQxMTYgYXQgLi4vZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY24xMC9kY24xMF9saW5rX2VuY29kZXIuYzo0
ODMgZGNuMTBfZ2V0X2RpZ19mcm9udGVuZCsweDY1LzB4YjAgW2FtZGdwdV0KMjAyMS0wMS0x
M1QxMDo1MjowMi4xMzUyMDUrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTMz
MV0gTW9kdWxlcyBsaW5rZWQgaW46IGZ1c2UgaXB0YWJsZV9tYW5nbGUgeHRfVENQTVNTIHh0
X3RjcHVkcCBicGZpbHRlciBpcF90YWJsZXMgeF90YWJsZXMgYWZfcGFja2V0IGRtaV9zeXNm
cyB1dmN2aWRlbyB2aWRlb2J1ZjJfdm1hbGxvYyB2aWRlb2J1ZjJfbWVtb3BzIHZpZGVvYnVm
Ml92NGwyIHZpZGVvYnVmMl9jb21tb24gdmlkZW9kZXYgbWMgbXNyIHNuZF9oZGFfY29kZWNf
cmVhbHRlayBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgbGVkdHJpZ19hdWRpbyBzbmRfaGRhX2Nv
ZGVjX2hkbWkgc25kX2hkYV9pbnRlbCBzbmRfaW50ZWxfZHNwY2ZnIHNvdW5kd2lyZV9pbnRl
bCBzb3VuZHdpcmVfZ2VuZXJpY19hbGxvY2F0aW9uIHNvdW5kd2lyZV9jYWRlbmNlIG5sc19p
c284ODU5XzEgZWRhY19tY2VfYW1kIG5sc19jcDQzNyBzbmRfaGRhX2NvZGVjIHZmYXQga3Zt
X2FtZCBmYXQgc25kX2hkYV9jb3JlIHNuZF9od2RlcCBrdm0gc291bmR3aXJlX2J1cyBzbmRf
c29jX2NvcmUgc25kX2NvbXByZXNzIHNuZF9wY21fZG1hZW5naW5lIGlycWJ5cGFzcyBwY3Nw
a3Igc25kX3BjbSBlZmlfcHN0b3JlIGFzdXNfbmJfd21pIHNuZF90aW1lciBhc3VzX3dtaSBz
cGFyc2Vfa2V5bWFwIHdtaV9ibW9mIHI4MTY5IHNuZCByZWFsdGVrIHNwNTEwMF90Y28gbWRp
b19kZXZyZXMgam95ZGV2IGsxMHRlbXAgc291bmRjb3JlIGkyY19waWl4NCBsaWJwaHkgdGhl
cm1hbCBhYyBhc3VzX3dpcmVsZXNzIHRpbnlfcG93ZXJfYnV0dG9uIGFjcGlfY3B1ZnJlcSBi
dHJmcyBibGFrZTJiX2dlbmVyaWMgbGliY3JjMzJjIHhvciByYWlkNl9wcSBkbV9jcnlwdCBh
bGdpZl9za2NpcGhlciBhZl9hbGcgcnQ1NTcyc3RhKE8pIGNmZzgwMjExIHJma2lsbCBoaWRf
bXVsdGl0b3VjaCBoaWRfZ2VuZXJpYyBhbWRncHUgaW9tbXVfdjIgZ3B1X3NjaGVkIHR0bSBp
MmNfYWxnb19iaXQgZHJtX2ttc19oZWxwZXIgc3lzY29weWFyZWEgc3lzZmlsbHJlY3Qgc3lz
aW1nYmx0IGZiX3N5c19mb3BzIGNlYwoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTIxMCswMTow
MCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1Mzg5XSAgY3JjdDEwZGlmX3BjbG11bCBj
cmMzMl9wY2xtdWwgY3JjMzJjX2ludGVsIGdoYXNoX2NsbXVsbmlfaW50ZWwgYWVzbmlfaW50
ZWwgZ2x1ZV9oZWxwZXIgeGhjaV9wY2kgY3J5cHRvX3NpbWQgeGhjaV9wY2lfcmVuZXNhcyBy
Y19jb3JlIHhoY2lfaGNkIGNyeXB0ZCBudm1lIGRybSB1c2Jjb3JlIHNlcmlvX3JhdyBjY3Ag
bnZtZV9jb3JlIHdtaSB2aWRlbyBiYXR0ZXJ5IGkyY19oaWQgYnV0dG9uIHNnIGRtX211bHRp
cGF0aCBkbV9tb2Qgc2NzaV9kaF9yZGFjIHNjc2lfZGhfZW1jIHNjc2lfZGhfYWx1YSBlZml2
YXJmcwoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTIxMSswMTowMCBsb2NhbGhvc3Qga2VybmVs
OiBbICAxNTUuNjQ1NDE3XSBDUFU6IDYgUElEOiA0MTE2IENvbW06IGt3b3JrZXIvdTMyOjM1
IFRhaW50ZWQ6IEcgICAgICAgICAgIE8gICAgICA1LjEwLjctMy4xLWRlZmF1bHQgIzEgb3Bl
blNVU0UgVHVtYmxld2VlZCAodW5yZWxlYXNlZCkKMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUy
MTIrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTQzMl0gSGFyZHdhcmUgbmFt
ZTogQVNVU1RlSyBDT01QVVRFUiBJTkMuIFRVRiBHYW1pbmcgRlg1MDVEVF9GWDUwNURUL0ZY
NTA1RFQsIEJJT1MgRlg1MDVEVC4zMTAgMTIvMjQvMjAxOQoyMDIxLTAxLTEzVDEwOjUyOjAy
LjEzNTIxNCswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1NDQyXSBXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGFzeW5jX3J1bl9lbnRyeV9mbgoyMDIxLTAxLTEzVDEwOjUy
OjAyLjEzNTIxNSswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1NTEyXSBSSVA6
IDAwMTA6ZGNuMTBfZ2V0X2RpZ19mcm9udGVuZCsweDY1LzB4YjAgW2FtZGdwdV0KMjAyMS0w
MS0xM1QxMDo1MjowMi4xMzUyMTUrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0
NTUxNV0gQ29kZTogMDAgOGIgNTQgMjQgMDQgODMgZmEgMDggNzQgNTkgN2UgM2EgODMgZmEg
MjAgYjggMDUgMDAgMDAgMDAgNzQgMWIgODMgZmEgNDAgYjggMDYgMDAgMDAgMDAgNzQgMTEg
ODMgZmEgMTAgYjggMDQgMDAgMDAgMDAgNzQgMDcgPDBmPiAwYiBiOCBmZiBmZiBmZiBmZiA0
OCA4YiA3NCAyNCAwOCA2NSA0OCAzMyAzNCAyNSAyOCAwMCAwMCAwMCA3NQoyMDIxLTAxLTEz
VDEwOjUyOjAyLjEzNTIxNiswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1NTE2
XSBSU1A6IDAwMTg6ZmZmZmIyYzQ0MjUwNzg3OCBFRkxBR1M6IDAwMDEwMjk3CjIwMjEtMDEt
MTNUMTA6NTI6MDIuMTM1MjE3KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU1
MTddIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5OTJlMDlkMjAwMDAgUkNYOiAw
MDAwMDAwMDAwMDAwMDA4CjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjE4KzAxOjAwIGxvY2Fs
aG9zdCBrZXJuZWw6IFsgIDE1NS42NDU1MThdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6
IDAwMDAwMDAwMDAwMDU1NmYgUkRJOiBmZmZmOTkyZTExMTQwMDAwCjIwMjEtMDEtMTNUMTA6
NTI6MDIuMTM1MjE5KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU1MTldIFJC
UDogZmZmZjk5MmU4YTVlMDFjMCBSMDg6IGZmZmZiMmM0NDI1MDc4N2MgUjA5OiAwMDAwMDAw
MDAwMDAwMDAxCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjIxKzAxOjAwIGxvY2FsaG9zdCBr
ZXJuZWw6IFsgIDE1NS42NDU1MjBdIFIxMDogMDAwMDAwMDAwMDAwMDAwNCBSMTE6IDAwMDAw
MDAwMDAwMDAwMDQgUjEyOiBmZmZmYjJjNDQyNTA3OGE4CjIwMjEtMDEtMTNUMTA6NTI6MDIu
MTM1MjIyKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU1MjBdIFIxMzogMDAw
MDAwMDAwMDAwMDAwMCBSMTQ6IGZmZmY5OTJlMDliYWU4MDAgUjE1OiBmZmZmOTkyZThhNWUw
MDAwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjIzKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6
IFsgIDE1NS42NDU1MjJdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTky
ZWI4YjgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKMjAyMS0wMS0xM1QxMDo1
MjowMi4xMzUyMjMrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTUyM10gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwoyMDIxLTAx
LTEzVDEwOjUyOjAyLjEzNTIyNCswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1
NTIzXSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1IzOiAwMDAwMDAwMTYyMTgyMDAwIENSNDog
MDAwMDAwMDAwMDM1MDZlMAoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTIyNSswMTowMCBsb2Nh
bGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1NTI0XSBDYWxsIFRyYWNlOgoyMDIxLTAxLTEzVDEw
OjUyOjAyLjEzNTIyNiswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1NjAwXSAg
ZGNfY29tbWl0X3N0YXRlKzB4ODU2LzB4YTYwIFthbWRncHVdCjIwMjEtMDEtMTNUMTA6NTI6
MDIuMTM1MjI3KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU2NjldICBhbWRn
cHVfZG1fYXRvbWljX2NvbW1pdF90YWlsKzB4NTQwLzB4MjM2MCBbYW1kZ3B1XQoyMDIxLTAx
LTEzVDEwOjUyOjAyLjEzNTIyOSswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1
Njc1XSAgPyB0dG1fYm9fcmVsZWFzZSsweGVhLzB4MzIwIFt0dG1dCjIwMjEtMDEtMTNUMTA6
NTI6MDIuMTM1MjMwKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU2NzhdICA/
IGRtYV9yZXN2X2luaXQrMHgxYy8weDQwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjMxKzAx
OjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU2ODFdICA/IHR0bV9ib19tb3ZlX2Fj
Y2VsX2NsZWFudXArMHgxZmEvMHg0MDAgW3R0bV0KMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUy
MzIrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTcyOF0gID8gYW1kZ3B1X2Jv
X21vdmUrMHgxMzcvMHgyOTAgW2FtZGdwdV0KMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUyMzMr
MDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTczMF0gID8gdHRtX2JvX2hhbmRs
ZV9tb3ZlX21lbSsweDlmLzB4NDIwIFt0dG1dCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjM0
KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU3MzNdICA/IHR0bV9ib192YWxp
ZGF0ZSsweDEzMi8weDE1MCBbdHRtXQoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTIzNSswMTow
MCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1Nzc5XSAgPyBhbWRncHVfYm9fcGluX3Jl
c3RyaWN0ZWQrMHgyODEvMHgyYTAgW2FtZGdwdV0KMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUy
NjArMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTc4Ml0gID8gdHRtX2JvX21v
dmVfdG9fbHJ1X3RhaWwrMHgyOC8weGQwIFt0dG1dCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1
MjYyKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU4NDldICA/IGRtX3BsYW5l
X2hlbHBlcl9wcmVwYXJlX2ZiKzB4MjE3LzB4MmMwIFthbWRncHVdCjIwMjEtMDEtMTNUMTA6
NTI6MDIuMTM1MjYzKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU4NThdICBj
b21taXRfdGFpbCsweDk0LzB4MTIwIFtkcm1fa21zX2hlbHBlcl0KMjAyMS0wMS0xM1QxMDo1
MjowMi4xMzUyNjQrMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NTg2NV0gIGRy
bV9hdG9taWNfaGVscGVyX2NvbW1pdCsweDEwNy8weDEzMCBbZHJtX2ttc19oZWxwZXJdCjIw
MjEtMDEtMTNUMTA6NTI6MDIuMTM1MjY1KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1
NS42NDU4NzFdICBkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfZHVwbGljYXRlZF9zdGF0ZSsw
eGM5LzB4ZTAgW2RybV9rbXNfaGVscGVyXQoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTI2Nisw
MTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1ODc3XSAgZHJtX2F0b21pY19oZWxw
ZXJfcmVzdW1lKzB4OTIvMHgxNjAgW2RybV9rbXNfaGVscGVyXQoyMDIxLTAxLTEzVDEwOjUy
OjAyLjEzNTI2NyswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ1OTQ0XSAgZG1f
cmVzdW1lKzB4NDYxLzB4NTMwIFthbWRncHVdCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjY4
KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDU5ODldICBhbWRncHVfZGV2aWNl
X2lwX3Jlc3VtZV9waGFzZTIrMHg1Mi8weGMwIFthbWRncHVdCjIwMjEtMDEtMTNUMTA6NTI6
MDIuMTM1MjY5KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDYwMzRdICBhbWRn
cHVfZGV2aWNlX3Jlc3VtZSsweGNlLzB4MzkwIFthbWRncHVdCjIwMjEtMDEtMTNUMTA6NTI6
MDIuMTM1MjcwKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDYwMzhdICA/IHBj
aV9wbV90aGF3KzB4OTAvMHg5MAoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTI3MSswMTowMCBs
b2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ2MDQwXSAgZHBtX3J1bl9jYWxsYmFjaysweDRi
LzB4MTMwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1MjcyKzAxOjAwIGxvY2FsaG9zdCBrZXJu
ZWw6IFsgIDE1NS42NDYwNDJdICBkZXZpY2VfcmVzdW1lKzB4MTA4LzB4MjEwCjIwMjEtMDEt
MTNUMTA6NTI6MDIuMTM1MjcyKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDYw
NDNdICA/IGRwbV9zaG93X3RpbWUrMHhkMC8weGQwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1
MjczKzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDYwNDVdICBhc3luY19yZXN1
bWUrMHgxOS8weDQwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1Mjc1KzAxOjAwIGxvY2FsaG9z
dCBrZXJuZWw6IFsgIDE1NS42NDYwNDZdICBhc3luY19ydW5fZW50cnlfZm4rMHgzNy8weDE0
MAoyMDIxLTAxLTEzVDEwOjUyOjAyLjEzNTI3NiswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBb
ICAxNTUuNjQ2MDQ4XSAgcHJvY2Vzc19vbmVfd29yaysweDFmYi8weDNjMAoyMDIxLTAxLTEz
VDEwOjUyOjAyLjEzNTI3NyswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ2MDUw
XSAgd29ya2VyX3RocmVhZCsweDJkLzB4M2UwCjIwMjEtMDEtMTNUMTA6NTI6MDIuMTM1Mjc4
KzAxOjAwIGxvY2FsaG9zdCBrZXJuZWw6IFsgIDE1NS42NDYwNTFdICA/IHByb2Nlc3Nfb25l
X3dvcmsrMHgzYzAvMHgzYzAKMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUyNzkrMDE6MDAgbG9j
YWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NjA1Ml0gIGt0aHJlYWQrMHgxMTcvMHgxMzAKMjAy
MS0wMS0xM1QxMDo1MjowMi4xMzUyODArMDE6MDAgbG9jYWxob3N0IGtlcm5lbDogWyAgMTU1
LjY0NjA1NF0gID8ga3RocmVhZF9wYXJrKzB4OTAvMHg5MAoyMDIxLTAxLTEzVDEwOjUyOjAy
LjEzNTI4MSswMTowMCBsb2NhbGhvc3Qga2VybmVsOiBbICAxNTUuNjQ2MDU2XSAgcmV0X2Zy
b21fZm9yaysweDIyLzB4MzAKMjAyMS0wMS0xM1QxMDo1MjowMi4xMzUyODIrMDE6MDAgbG9j
YWxob3N0IGtlcm5lbDogWyAgMTU1LjY0NjA1OF0gLS0tWyBlbmQgdHJhY2UgMjY0ZjU1ZGU3
NzBhZWJjMiBdLS0tCg==
--------------F6FAEED47EC2E8547AE58C1E--
